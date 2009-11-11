From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release 
	workflow
Date: Wed, 11 Nov 2009 11:05:57 -0200
Message-ID: <a4c8a6d00911110505m2f21a787sfb3e0d6c130b0b4d@mail.gmail.com>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm>
	 <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: rocketraman@fastmail.fm
X-From: git-owner@vger.kernel.org Wed Nov 11 14:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Ctg-00085W-T4
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 14:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZKKNFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 08:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZKKNFx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 08:05:53 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:39919 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbZKKNFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 08:05:53 -0500
Received: by fxm21 with SMTP id 21so982033fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=nIECFk2tQs44TKHG4xtn7a6S9/APcWUIEmj2T0OvQ0Q=;
        b=evan1gXPAtohIVYwuqCFVtsY6wqC3bZTYRqztXlehIP0Jp6/8vvulOQaM+HV4eooox
         m2WOo8R8kfrhUx3fKKbJJToSE0FOCxFr3xmvuYCQdqn1gaTrHd2Gao4+Wde2RbWEsJqq
         g5REgVLlRbxwlGpZUjzP5A6p7VfVoJbxSgFIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UAimItrkRMNhABoN0WhKIFXveOsxi7i9/DEDRmYPGXgbPOIUdlwyEoFE7P8mnf5bmD
         9Wdiqrxfpk6FFamLU6Jgw455fL+5UtP1h7x5KqaOjtsXDN9hYH2ASe0kkmzomA1Nkjoj
         i3jI6BYyghVJ1OhDrpq0Duft+wFg7TWkOtXe0=
Received: by 10.204.48.210 with SMTP id s18mr1418804bkf.162.1257944757547; 
	Wed, 11 Nov 2009 05:05:57 -0800 (PST)
In-Reply-To: <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132649>

Hi,

On Tue, Nov 10, 2009 at 2:08 PM,  <rocketraman@fastmail.fm> wrote:
> From: Raman Gupta <raman@rocketraman.com>
>
> The gitworkflows man page currently provides an overview of the workflows
> used by git.git itself to serve as inspiration for people to use when
> designing their own workflows. The current man page does a reasonable
> job at describing the development process, but it does not contain any
> guidance as to the workflow used for releases. Now add a basic
> introduction to the branch management required for a release, so that a
> reader may understand how the maint, master, next, and topic branches are
> affected.
Here
http://git.kernel.org/?p=git/git.git;a=blob;f=Checklist.txt;h=37745f39487537117fb7f3a9a6f5b8e7d989a884;hb=refs/heads/todo
there is a release checklist, maybe you could extend your patch to
include more information from this?
