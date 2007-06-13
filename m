From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 16:40:18 +0100
Message-ID: <200706131640.22588.andyparkins@gmail.com>
References: <18031.64456.948230.375333@lisa.zopyra.com> <Pine.LNX.4.64.0706131559210.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 17:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUxT-0008LU-50
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757781AbXFMPka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757968AbXFMPk3
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:40:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:61205 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781AbXFMPk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:40:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so440711ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 08:40:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=anGy8n3OZh4MlbD1zxuA0tbX77Wgp9JUobJz2lwF4v03TLzkH0hddRy2Jhg6cwhdgEeTOsZHfNrDYZlTbZjTA8iic1CJUzM7ibiIBgNqZZyxanwdlq8rA3HAakhCRl5dxQG9WFBnO8aZroocQlgrNtKJSre14nus4FSKO7Zs2ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RR0qeWBlyzgBBqdP248Ev7KgjN4dG/VJ704BoAJeC/8HHmHgWZDIxzUfzQgKZ88RuMK1oTaTGRUmS9F5xDgyQ6U3msVSjdwKnMiQ5vmk+jcXw7P0NYxoEQk5J2uitD+xVQlql3Z1HcltrIjE7NespW/6ozNo15JpTa7+gZNELCA=
Received: by 10.67.102.12 with SMTP id e12mr1345358ugm.1181749227641;
        Wed, 13 Jun 2007 08:40:27 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c24sm1859484ika.2007.06.13.08.40.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2007 08:40:27 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0706131559210.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50079>

On Wednesday 2007 June 13, Johannes Schindelin wrote:

> The other thing, if you have to, is to put all dirty changes into the
> index before pull. Something like "git add $(git ls-files --modified)".

Or the shiny new

 git add -u

which works a treat :-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
