From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 16:10:19 +0100
Message-ID: <fabb9a1e0911300710t33ddfb94wb2b8c1d23a8f5ac2@mail.gmail.com>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 16:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7tl-00016l-Dc
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 16:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbZK3PKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 10:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbZK3PKd
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 10:10:33 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:61506 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZK3PKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 10:10:33 -0500
Received: by vws35 with SMTP id 35so1085928vws.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=XGIve03481QsKYpZWjrckV6rgH76VdcL0pZyJ9itvXE=;
        b=PUHEsgCvIQ5YfBReiqAniPjbLk3vIyxrppU+NSwAPxwxEzeAipjHIt8iTSmZdskoIJ
         lzx3ojBPw6j4ah6H+mW78Mo5JCMejQthbOMyhF/TqQjxsQwwUrD5Y0Z+N6NJSHdIKZek
         5VKmT1jyawdoaPg3HNOZHgYmn3dtSQJMKEJ4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tOaIFi9XZt/y4zZUT+GUvLty35i0gsc2F2EvigS+6hFlA/exw94AXOXkTSxeQOlBSr
         WmlYZsasA5fnS4eZqZPICIzXZSdC0+DIOWF99v7L6mX9hgPDHkIAxduavcrdnSbUVQoR
         dKoqSL1gTeey1xcnDBX+1nMDWji8ABMGu90VM=
Received: by 10.220.128.1 with SMTP id i1mr5304144vcs.87.1259593839070; Mon, 
	30 Nov 2009 07:10:39 -0800 (PST)
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134111>

Heya,

On Mon, Nov 30, 2009 at 15:43, Bernhard R. Link <brlink@debian.org> wrote:
> Those patches are a bit rough and mostly intended to show how it could work
> and to allow experimenting with it.

Given the experimental nature of your patches it would probably have
been appropriate to mark them "RFC" (request for comment). You can do
so by running: `git format-patch --subject-prefix="RFC PATCH"` instead
of "git format-patch".

-- 
Cheers,

Sverre Rabbelier
