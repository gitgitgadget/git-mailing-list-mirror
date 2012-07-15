From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Mon, 16 Jul 2012 00:48:09 +0300
Message-ID: <CAAa3hFOEtx7d8QzCyBLJEw7kjEb0oPaT=EnFiY3DdApnkHt+hg@mail.gmail.com>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
	<loom.20120714T114718-783@post.gmane.org>
	<7vzk725c86.fsf@alter.siamese.dyndns.org>
	<7vr4se5bg4.fsf@alter.siamese.dyndns.org>
	<CAAa3hFOv39DhuEDTyJUm1pzB-X1gBiV8FXuqW6TidOtQw9CUng@mail.gmail.com>
	<7vmx32590u.fsf@alter.siamese.dyndns.org>
	<CAAa3hFMNf_wA22ngypSu379jr31r3L3yAjTkvDUd_L-mVwPJkA@mail.gmail.com>
	<500301BF.9080505@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqWgP-0001N0-CL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 23:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab2GOVsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 17:48:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35222 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2GOVsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 17:48:10 -0400
Received: by pbbrp8 with SMTP id rp8so8950430pbb.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=4dvI2AdonS/hhvL+lBH1bT5VqsvCESbzXQSoLdB07lM=;
        b=saVBnrY05Tk6hioyWDXK/kyKTG2ozQW0VrVOzpPqr4sztA44xEWWFvQrZXkFxsoSCz
         jTrf+cUQNvJH9AdzKU9N4U5TTcqayIRQuhisxrZqJTUHeyhyGJnzDBInILOdFZaOURuz
         sYRZSOHN1AdyvOSR4sJXUoQ5khuoL77XlPLn2hSc5h/bq3hMwiOQREWVTJNGioLqKyOm
         TRBpVX1vnw3vAxAxFool3MOhhkfHoEnD+eZImxCsXncV80y2ElqIV9mhsRAKm80L87u2
         y5lMRe9fv9d30PdKBRJ1FlOzrk3VbEwWMnhP0xJwaxF+NTkQPeJJ2xp8qpnnWvH7b5hJ
         +urw==
Received: by 10.66.74.69 with SMTP id r5mr18308000pav.56.1342388889560; Sun,
 15 Jul 2012 14:48:09 -0700 (PDT)
Received: by 10.68.231.33 with HTTP; Sun, 15 Jul 2012 14:48:09 -0700 (PDT)
In-Reply-To: <500301BF.9080505@ira.uka.de>
X-Google-Sender-Auth: cJ-VI3DAX1GKZb0MgGqN5yf_NnI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201486>

On Sun, Jul 15, 2012 at 8:45 PM, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> Am 15.07.2012 00:24, schrieb Zeeshan Ali (Khattak):
>
>> On Sun, Jul 15, 2012 at 12:26 AM, Junio C Hamano<gitster@pobox.com>
>> wrote:
>>>
>>> "Zeeshan Ali (Khattak)"<zeeshanak@gnome.org>  writes:
>>>
>>>> What about '^' and '^^' that I suggested?
>
>
> If you want a shortcut, you might try this:
>
> echo "ref: HEAD" > .git/h
>
> Then you can use 'h' instead of 'HEAD'.
>
> Tested it and it seemed to work. If not someone on this list surely will
> correct me.

Thanks, was hoping to have something thats supported out of the box in
future git but I guess I can settle for a local hack too. :)


-- 
Regards,

Zeeshan Ali (Khattak)
FSF member#5124
