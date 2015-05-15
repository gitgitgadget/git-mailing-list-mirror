From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] git help: group common commands by theme
Date: Fri, 15 May 2015 13:48:55 -0700
Message-ID: <xmqqiobtftxk.fsf@gitster.dls.corp.google.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<CAPig+cTAMrQEfK81WWn3honj5yL5RjYvt13P63kZoZ+pQ1f98g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:49:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMXY-0003yu-HK
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945957AbbEOUs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 16:48:59 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36556 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945943AbbEOUs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 16:48:58 -0400
Received: by igbpi8 with SMTP id pi8so5696767igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=WQXTPc5FVyoPkskPlmgMDYITQTWkq6q3YiyAXpQWJ0w=;
        b=o/7iO++Y2lKxO3gN2JqoFwIsEt8DKZIKDSxjJxobHJYjOj4aqZ1IxayRhNBUEM+hD1
         of8+g7TnER118FCGmzPALnmlUf9gOcwT5o0nCWQeVa1j6i+bmAj3fJa42D15FfTYbfB6
         SaiUrQDpQLhjCg3bOhiG4xdfw0imhmW/5yM+EXrfUefbE/+ZW/URH+ebGLbtChKA5TSc
         RQvbnBYjiskO9jn7TWiGO+2TuVNKhLMAOS/iWY6e19PA6Xg/+yMucQvZGyktgCu7y+Ph
         +ERu4BK1MEuVRZKcFvx1/ZNE7j51Drpdp3Eb3dKNXweqeLv23nnQ2YUyRSjLFziZ3mDY
         +n6A==
X-Received: by 10.42.213.136 with SMTP id gw8mr23104679icb.95.1431722937683;
        Fri, 15 May 2015 13:48:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id r4sm2377685igh.9.2015.05.15.13.48.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 13:48:56 -0700 (PDT)
In-Reply-To: <CAPig+cTAMrQEfK81WWn3honj5yL5RjYvt13P63kZoZ+pQ1f98g@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 15 May 2015 16:41:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269182>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> rebased on 'next' (a2776d4)
>
> Something to keep in mind for the future: It's usually easier to
> manage preparatory cleanup patches by incorporating them into the
> series which needs/wants them rather than posting them as separate
> topics. That way, your patch series isn't held hostage by those
> separate topics.

Not a big deal in this case, as I was very well aware that there was
a preparatory change sent, so no harm done to me personally; I even
asked S=C3=A9bastien to rebuild on top of that patch.

=46or people who are helping to review the series but haven't paid
attention to everything that was said on the list (read: almost all
the people), it would have been better if it said "depends on
bf990a2", instead of saying that it depends on the 'next' as a whole
(which it doesn't).

Thanks.
