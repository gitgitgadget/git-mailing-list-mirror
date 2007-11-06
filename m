From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Rearrange git-format-patch synopsis to improve clarity.
Date: Wed, 7 Nov 2007 08:08:52 +1100
Message-ID: <ee77f5c20711061308p11c091f7h730b93c9b49542df@mail.gmail.com>
References: <119421522591-git-send-email-dsymonds@gmail.com>
	 <ee77f5c20711051432w284cf22dx71192c145d25dced@mail.gmail.com>
	 <473081C2.7060106@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpVg1-0003AH-CP
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596AbXKFVIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756533AbXKFVIz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:08:55 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:54930 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbXKFVIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:08:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1859346rvb
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/YZZ9wg/1IWzkAt5yWW8fiTqei1dofzkIXvzuTObCbQ=;
        b=jFTiPKcISkrTFGKXvJ1zwf2XdOP98NBRiW80vPv16DbgOfqYZ9pvV+iZoAiif4toGA6oC/givBAHzRdvmNOCbGHlkEBVE3wg9ZJTY0GeUs/D6arstnNN1Z0w2F1LuLI31H5uiLV23MOt4qGBVqNlr8i0PI9kN+lcXRbGAvfhTRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P/xq5YWR6xxjVAjUG300RmwNIV9n+p0SfPe6njbFyoG9Tc143f1bTO24n7bT2ErWMpAu6KsJmUWYcphU9YBlYkN7avPC7gVsEqUWy9YDh/GZMAWL4uonnrxfZjPYmZPLS1lN8jn4hhVIUVYu8ZPSESv56FJ++d3UlIqsnP55Apc=
Received: by 10.141.18.14 with SMTP id v14mr3145856rvi.1194383332911;
        Tue, 06 Nov 2007 13:08:52 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Tue, 6 Nov 2007 13:08:52 -0800 (PST)
In-Reply-To: <473081C2.7060106@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63727>

On 11/7/07, Jon Loeliger <jdl@freescale.com> wrote:
> David Symonds wrote:
> > Now that I look at it again, it seems the long options look quite
> > inconsistent. I think it should be either
> > --numbered-files/--no-numbered-files or --numbered/--no-numbered. My
> > preference is with the latter (for brevity), but that breaks
> > backward-compatibility.
> >
> > Would you accept a patch that changed --numbered-files to --numbered,
> > and kept the former as a synonym?
>
> There are two forms of numbered file output names:
> the traditional "0001-Foo-the-bar" and just "1" styles.
> Please don't break that.  Both are needed.

Oh, I certainly wasn't proposing removing any functionality; merely
renaming the option to select it so as to be consistent.


Dave.
