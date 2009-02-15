From: E R <pc88mxer@gmail.com>
Subject: Re: not all tests pass when on an NFS partition
Date: Sun, 15 Feb 2009 14:19:26 -0600
Message-ID: <3a69fa7c0902151219y270681f7r17a108fdf44213ad@mail.gmail.com>
References: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com>
	 <7vk57vjqsd.fsf@gitster.siamese.dyndns.org>
	 <Aq-rucZsypJQU8SHtTE8X62cEZZn-xSpOOIfA-I5czdtCkm2IyMjDw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Feb 15 21:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYnU0-0003MH-MJ
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 21:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZBOUT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 15:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbZBOUT2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 15:19:28 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:61691 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbZBOUT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 15:19:27 -0500
Received: by yx-out-2324.google.com with SMTP id 8so868457yxm.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 12:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fFMOMBsSij/RcKGNV0nj3o07m2uKljCVTvYiRsGA0p4=;
        b=MVijUa6P5/8y9yDNxA7NUUD4h5Q4eaS5xG8T2if0V9Z0n2/eVVn3TMRjsIXl7DV+S7
         XhDpQzamNZk/3elVbDT+ys6xCAxdG0pNeHMhv0cDvaqMI4QoazUXwajsp39//k+AyHxA
         BhXT36SeK7ZfiMIRMcwtZbnTKprbNn4FZpggE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fmguFJ2yD5wf2oY/jdBQwyM+0yJj2qX4fCo2zoD0rCDg6+fx7SYc6sEXT02sNK1Q10
         /PmsxYZLbMNgL8oM+bz5lSrQ0pUMrg6xf3knGLdgSQCuygKuNdx6HuWI8NJWi9aDeYvr
         vxjevXNJtS0/O+RJmeVfH6dKYzK7KdVWowTq4=
Received: by 10.100.105.9 with SMTP id d9mr5512669anc.142.1234729166491; Sun, 
	15 Feb 2009 12:19:26 -0800 (PST)
In-Reply-To: <Aq-rucZsypJQU8SHtTE8X62cEZZn-xSpOOIfA-I5czdtCkm2IyMjDw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110055>

On Thu, Feb 12, 2009 at 6:54 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:

> RHEL 5.2? me too.
>
> RHEL 4.7 works fine, same NFS server (running 5.2).

Yes - it's Centos 5.2. Very interesting.
