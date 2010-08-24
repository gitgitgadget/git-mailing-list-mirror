From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/32] cache-tree: abstract out write_sha1_file from
 cache_tree_update()
Date: Tue, 24 Aug 2010 17:41:56 -0500
Message-ID: <20100824224156.GC2376@burratino>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
 <1282688422-7738-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 00:43:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo2Db-0002cy-Hg
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab0HXWnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:43:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35139 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0HXWnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 18:43:39 -0400
Received: by qwh6 with SMTP id 6so6604242qwh.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RLnvxSPkU7s+x+NOvLhRkOSklHVRlArQo1K4ISONQ/w=;
        b=ClJXtoSOdBMgs6Khg08fXmi7ZGysQsebqETrusUsB2HyVAF03K0xKThSbLWMpITtIl
         CDAai49Jk9559ZsjZ/IqMlbBNN5pCYEzWQMSg8aC0BBoghvIAZbiwNofVIaSKDKAkccJ
         6Cn/TbjO1VP4tS9oPKlIfeeWqlgaAdRmH2kho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Fi5NLPhPC2pHqDhCtbd6LKd7cdhQu2lY5/XJouAhYveKIHvSXm1AljB7yeKcCkL89P
         LZe0y5AS1PQqqQbWFGTNGFiLD3qzdD2a9nvuk7PRm3goKu5W8ABwKUDwI6ZzvJjA6mFV
         77AaLYtUWvNkkrYh4HJFdjrmv3gNoCMCQrN6g=
Received: by 10.229.249.212 with SMTP id ml20mr5372901qcb.119.1282689817985;
        Tue, 24 Aug 2010 15:43:37 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e6sm700402qcr.5.2010.08.24.15.43.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:43:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282688422-7738-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154378>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This allows cache-tree to produce trees directly in a pack, for insta=
nce.

Neat.
