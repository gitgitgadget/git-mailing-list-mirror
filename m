From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 03/10] transport-helper: add 'force' to 'export' helpers
Date: Mon, 11 Nov 2013 17:47:39 -0600
Message-ID: <CAMP44s0GJOTPA1_KSG=xSNGfdFJxLXD10b+Dm2OeaB5FRz61bw@mail.gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-7-git-send-email-felipe.contreras@gmail.com>
	<xmqq7gcejyuc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg1Cr-00043Y-2z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab3KKXrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:47:42 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:54107 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab3KKXrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:47:40 -0500
Received: by mail-lb0-f182.google.com with SMTP id w6so3914657lbh.41
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KU1Im0BV7N+KX3G+gbdFZ3iQUEdMktohm61TPwzjEik=;
        b=gOaeG3kagrj9pAsBsCMFw1kJkBxH3vyTrNS0Arbvel90Ee7XFTHHAGSogQUpoGIs4w
         DOrM1PZ8+bak/Z9nRGtOVElSNjOd6MKFcmZYXXSprwtzmtha59ySIjVMio9vSALruvu7
         KS+WZiOF+5PdBTSHjMvgjJbldGbieijYUJEtSFlZPt6RTUdvGQgBJ+DgKqaThV8dvGYP
         6s3IWLhm/wtgslTH/L0DjtOTpl8eDEOCCIHtsBlRJyBtk1ej6jHPTI++tXGgNuNPx8Rz
         6fK3xFz/Eu+b4z2gVQT7cfCqoQQMbC/wOB+tK30rWecHt/QoNEs+JurqB5tx5CXa8gna
         j3kA==
X-Received: by 10.152.6.74 with SMTP id y10mr25159768lay.16.1384213659542;
 Mon, 11 Nov 2013 15:47:39 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 15:47:39 -0800 (PST)
In-Reply-To: <xmqq7gcejyuc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237681>

On Mon, Nov 11, 2013 at 5:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Otherwise they cannot know when to force the push or not (other than
>> hacks).
>>
>> Tests-by: Richard Hansen <rhansen@bbn.com>
>> Documentation-by: Richard Hansen <rhansen@bbn.com>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> Didn't we agree that this should be warn, not die?

Yes, and I assumed you would do it without a reroll, because no reroll
was needed. I've updated my side as well now, for the next reroll.

-- 
Felipe Contreras
