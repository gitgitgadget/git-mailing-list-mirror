From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 15:07:54 +0200
Message-ID: <CABPQNSYwHaE35UiZC8qqBMyjmY37VuTK_hqFyRcbhJKnhYzz2Q@mail.gmail.com>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
 <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de> <vpqy5kgdctm.fsf@bauges.imag.fr>
 <007001cd9016$8f980f80$aec82e80$@schmitz-digital.de> <vpq4nn4d968.fsf@bauges.imag.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 11 15:08:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBQCq-0001NU-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 15:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab2IKNIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 09:08:37 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33105 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2IKNIf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 09:08:35 -0400
Received: by vcbfy27 with SMTP id fy27so543707vcb.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HZngUEkGkXZ2pcAxsnvl/U1BZP5Ch2PW8OQ/BY70YsY=;
        b=BhfiTRB5/aRwG3hUHUpdgpS0krYmxNBcYiFzxon1gRqA4lCH+6KowAduMUKfBH8VwH
         GwcBQ0lqCePL7lRRLFMSl8fBpXpsxVxq7PcGkcesOqj8IEDQLBjjqZqqBR+NlLb2snFF
         C5NRmkWYysw2H+GCTBnBdxlIIt6/GRtQKFod4z5wcZbvl9yJZNAKMTJ0tn4HTaaRj9fi
         SiYGODcUT1y7rYmLugESZ5I1XBWt1AlS04ERqNUUsPJ0LUmcyfkzUsbJTP2adi1YFQjA
         TE6MyPPTxboGkrvSTC3ri0MWxPuS2DaIIB26CGTBT0J5NJ1fOUNLGHzcszYCaes/RKcm
         rFqA==
Received: by 10.52.67.175 with SMTP id o15mr8015046vdt.71.1347368914975; Tue,
 11 Sep 2012 06:08:34 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Tue, 11 Sep 2012 06:07:54 -0700 (PDT)
In-Reply-To: <vpq4nn4d968.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205227>

On Tue, Sep 11, 2012 at 2:40 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> [ Re-adding git@vger in Cc, I guess it was meant to be so ]
>
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>
>>> Then, work on the tip of the topic branch you depend on instead of pu.
>>> These are more stable, as they will be rewritten only if this particular
>>> topic branch changes.
>>
>> These are not available from git hub. Or are they? How?
>
> I think they exist in some of the repos junio pushes to, but I don't
> remember how/which one.
>

You can usually find them here: https://github.com/gitster/git/branches

And Joachim's branch in particular:
https://github.com/gitster/git/tree/js/compat-itimer
