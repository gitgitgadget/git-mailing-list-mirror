From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Tue, 26 May 2015 13:21:01 -0700
Message-ID: <xmqqpp5njdjm.fsf@gitster.dls.corp.google.com>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
	<1431019501-30807-3-git-send-email-luke@diamand.org>
	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
	<554BBCBE.1020408@diamand.org>
	<xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>
	<554BCE25.5070308@diamand.org>
	<xmqqa8xgnlme.fsf@gitster.dls.corp.google.com>
	<xmqq3838nl5l.fsf@gitster.dls.corp.google.com>
	<554BE15B.3040303@diamand.org>
	<xmqqtwvom3t4.fsf@gitster.dls.corp.google.com>
	<556199A2.8090802@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 26 22:21:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxLLa-0007id-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 22:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbbEZUVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 16:21:06 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32959 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbEZUVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 16:21:03 -0400
Received: by igbpi8 with SMTP id pi8so69618576igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OiARBnjnkZcHjAv4ZuZam4qtnt67AqltH9kZkJK2ZC4=;
        b=YqrbZqC7kj+fZFp91SKGGTDW1Vj6/eqVXNmj3fpQPhQz+vHIZiiP1RN5bUzROMl0tw
         k3LvcypxCK0EDZrq6ccLkwpVxHFS4eyYaOCkcMp99H7c2GQ4tvMUYmddwJ1BtAj3wp4D
         /8hsSmhpdYmBSxvLmS8+j6s8I2Vfk5KJYAvMF5r2ATc+Te4iufWILFx3hnvHi/JpaHP9
         REqb6KiLFZT91cCQmvGSh96EO2J8cXmjLFvkY08VApz9tYsRUjTqxevvVY2m32J0JOHw
         1HNrWxZVhrYk8koiTGkqKrtXo/8ebF5q22NScaIrmXYE+pdn7W2bm6+picjpEYjIaWp+
         S/Mw==
X-Received: by 10.42.49.137 with SMTP id w9mr31850318icf.39.1432671662811;
        Tue, 26 May 2015 13:21:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id kl1sm98519igb.15.2015.05.26.13.21.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 13:21:01 -0700 (PDT)
In-Reply-To: <556199A2.8090802@diamand.org> (Luke Diamand's message of "Sun,
	24 May 2015 10:28:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269973>

Luke Diamand <luke@diamand.org> writes:

> On 07/05/15 23:16, Junio C Hamano wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>
> [Resurrecting old thread]
> ...
>
> To me, that seems to imply that for GIT_WINDOWS_NATIVE, we take the
> *second* branch and use "sh", so again, the the code as it stands will
> be fine. msysgit uses that path.
> ...
>
> I don't think we need to do anything. msysgit works fine with the
> origin "sh", "-c", ... code.

Thanks.  Let's merge what is in 'pu' down to 'next' then.
