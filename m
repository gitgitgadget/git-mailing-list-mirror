From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 16:41:54 +0100
Message-ID: <AANLkTinoET4vBxVdfSejFmzwRaA=0AVdie5gmMvx44T5@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org> <ih95fg$62b$1@dough.gmane.org>
 <201101201403.39174.trast@student.ethz.ch> <AANLkTinNNBupCi09_W60qdDGFc5CN-p=rKaf_FKW0kj1@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 16:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfwjH-0003FU-1o
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 16:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893Ab1ATPrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 10:47:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62197 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab1ATPrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 10:47:13 -0500
Received: by fxm20 with SMTP id 20so720844fxm.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=IgKNejsKkmt0EPHOVOULpO9cRzmG7WPk3YyhCbIoTSk=;
        b=akcfMl5k2q/YEHTttqqIq8JEHOVPtc0U6MjquMrNLHSUf8JcnvOgRqpGt78Kc/PKz0
         vyxe13184HqgYphSoAoaH+MtJLR/CLF9X8E9+WyET5qeh5N8YEtCAbfzLdUNW806Zr7X
         WFOJ/5ocoORcApXmmv8cW+QrAe0O/PeIIaPkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=nLym7mOrIow6S4SKA7wMESMEGrtWSiZIj7lVEOL9ZGPX7PCZYgdxo9MFBsSNYW3W6Q
         ZtVHfMWgej2tvF81kqGu8eokskMnAtL23y9zWrNSdHAQ09EB19NEmfWQj4dUxtp/KRFN
         PacMzo0TLSsEcrteUBijimE6Xr1Oy9Bw3pkD4=
Received: by 10.223.96.68 with SMTP id g4mr2261262fan.33.1295538431735; Thu,
 20 Jan 2011 07:47:11 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Thu, 20 Jan 2011 07:41:54 -0800 (PST)
In-Reply-To: <AANLkTinNNBupCi09_W60qdDGFc5CN-p=rKaf_FKW0kj1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165317>

On Thu, Jan 20, 2011 at 4:05 PM, Stephen Kelly <steveire@gmail.com> wrote:
> Ok so there was some movement with the result that no one uses what was set up.
>
> Presumably because git developers don't want a bug tracker.
>
> So how can I ensure that this particular issue doesn't get lost? Is
> there no way except hope that people get involved in fixing it
> straight away, and fix it straight away before they forget about it?
>

You could always fix it yourself, and submit a patch.
