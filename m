From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Make 'git stash -k' a short form for 'git stash save 
	--keep-index'
Date: Mon, 27 Jul 2009 14:37:28 -0700
Message-ID: <fabb9a1e0907271437x7ff04c0ao225b23a1363e265c@mail.gmail.com>
References: <cover.1248719786u.git.johannes.schindelin@gmx.de> 
	<76cdda0d6cf911449d16ebb86f54641620135fca.1248719786u.git.johannes.schindelin@gmx.de> 
	<fabb9a1e0907271424x5495a228r779efe9794848880@mail.gmail.com> 
	<alpine.DEB.1.00.0907272336290.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:37:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXtK-0004zN-L1
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 23:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbZG0Vhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZG0Vhu
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 17:37:50 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:6085 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbZG0Vht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 17:37:49 -0400
Received: by ey-out-2122.google.com with SMTP id 9so907631eyd.37
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JL+vrmt3KIrjwGwYGiWugBlfhOx/ZuCFbEw8kfA3FIM=;
        b=NZk4kcfFhLlXmM3MO1KXctU2sUZQRKo8kJ2+d6jVKgWsFKZUBrp2B3BOpHHP0D0IDY
         QoigYITt2qZJhmrQlqXyaol2sX4rhn/lQPjsapwbz9iJc75sxojPSQl7DYSFj9L+8psa
         TrO1dXjtMwlPz69k0/NAktEA2gVGrjxkcBeY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dOdFcnk9TBqaloeOcxWvLHg2cld7OCKyXs9IqdsMBa2NxmWqCgGI3U121gypqRUQZr
         qDP6JO9NhnYukl4PfhbjgCMB76FBYifw5cShQa7/XTdjeKcVQQW/PVGVVqg4s6Z/FBrn
         9iHblD7QOIctOLLZjRjBbjsJ/0Asxat8x9EBw=
Received: by 10.216.88.18 with SMTP id z18mr775043wee.78.1248730668115; Mon, 
	27 Jul 2009 14:37:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907272336290.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124200>

Heya,

On Mon, Jul 27, 2009 at 14:37, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Yes, it does, but it causes carpal tunnel.

True that, but it's consistent at least :).

-- 
Cheers,

Sverre Rabbelier
