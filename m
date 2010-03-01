From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: error when installing 1.7.0.1: "ImportError: No module named 
	distutils.core"
Date: Mon, 1 Mar 2010 18:26:19 +0100
Message-ID: <fabb9a1e1003010926p7fdaf66cm6b8830bbb18e8477@mail.gmail.com>
References: <20100301170410.GG17508@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Mon Mar 01 18:26:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm9OI-00086g-BP
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 18:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab0CAR0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 12:26:41 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37137 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab0CAR0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 12:26:41 -0500
Received: by pwj8 with SMTP id 8so1776249pwj.19
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=OanZhHyjr1TznPsiKQUi4Ig6Zf9N9goqkXTAFlbxCYc=;
        b=mWQ4DfS6iDjiRXuNaHvl1ahV0ipuHanIxBmCJpxVZ7eZCEjMTF1bbPaxQfyQ59RWT9
         mVcZsJntT2nA7QdJwlRmdxtOVcHa6C4pjbp5ZwRFbq7FsApDp3lG0FhmN6+m2aLFz2Hl
         0XVYYhO9M/nHX956MqEapZYK8eV3ELquyElSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xzji26NPxd/ohugUBfBXwYauttBGtTwAa8oZ8UgA2DeXcHCfq86Ars0kND7j7e3SF3
         N1NZTyd2s4fseraLK6RzXmmTVaaUtiCCMLz6AxUBxRfK3ohMsYk/UjKZEio/d/d6icy2
         eqwZ8vDQsGE/G0aRehvue6Jc29ydcYFco04Ic=
Received: by 10.142.151.22 with SMTP id y22mr2719190wfd.126.1267464399194; 
	Mon, 01 Mar 2010 09:26:39 -0800 (PST)
In-Reply-To: <20100301170410.GG17508@cs-wsok.swansea.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141336>

Heya,

[please don't cull the cc list]

On Mon, Mar 1, 2010 at 18:04, Oliver Kullmann <O.Kullmann@swansea.ac.uk> wrote:
> Okay, with --without-python it works now.
> If it's not needed for most people, wouldn't it be
> better that this would be the default?

I don't think that's a good idea, I'd rather give it some exposure and
catch bugs like these, and then when we start using it (hopefully
soon) we won't run into any unexpected build troubles.

-- 
Cheers,

Sverre Rabbelier
