From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Fri, 20 Feb 2009 09:28:38 +0000
Message-ID: <320075ff0902200128o6b9772a4tcbd652e7654524e@mail.gmail.com>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com>
	 <20090218163002.GB22848@spearce.org>
	 <320075ff0902200127m3e516621m60a608bc891ab992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRmz-0007M6-Pv
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbZBTJdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 04:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbZBTJdv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:33:51 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:54259 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbZBTJdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 04:33:49 -0500
Received: by bwz5 with SMTP id 5so2262023bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=rx+PT2/5BVkegMJDv9qimBAyLT9eMLdP8iM0EAmlV1Q=;
        b=Myd819nqXT2LATRQ63j2P58oSxYsh1XX83N9rp8KtTriMUFsgCh4ouEK+95nDWA+X4
         UnEEfhsbLszuaB5tcHWctcsCiRDutblus/h+g3rorc3Y2pT21aY7I4CE5qmGc2BvRFSD
         JTpdTbN7wrjlXTJNI/lrXVlTUnCqAzxVopuls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=LuR6c53TFwXNC207ISCyTaP/1RKLp/JQJz5kwfzjiK8mfupm5HBKKfBmx6eGqLVlxr
         apiV5JtK4W6DY32u2MsSu0n2jU8KaN6ADzOMVV4ZRyKcceyWZe+UFJgOm9bSAvjeraf0
         cE/r8nS5cf/zHjshcFk0SMHpyoYY74LydXmio=
Received: by 10.103.138.16 with SMTP id q16mr1393096mun.114.1235122118079; 
	Fri, 20 Feb 2009 01:28:38 -0800 (PST)
In-Reply-To: <320075ff0902200127m3e516621m60a608bc891ab992@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110829>

On Wed, Feb 18, 2009 at 4:30 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> Nigel Magnay <nigel.magnay@gmail.com> wrote:
> > +public class ObjectId extends AnyObjectId implements Serializable {
>
> We should define our own serialVersionUID:
>
>  private static final long serialVersionUID = 1L;
>
> is good enough to make Java happy.

I'll re-roll. Actually both that and the whitespace damage I'm
partially blaming on eclipse. Eclipse curiously removes the warning to
declare serialVersionUID if you declare both writeObject and
readObject - that's wrong!

Also the formatting came from
.settings/org.eclipse.core.resources.prefs which has a tab policy of
"Tabs only" which has overridden my environment setting of
spaces-only.

I can modify it to spaces only - but the comment in 9268ced9d38 talks
about spaces-per-tab..?
