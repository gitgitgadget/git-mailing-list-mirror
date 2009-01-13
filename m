From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 16:12:38 -0500
Message-ID: <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>
References: <loom.20090113T145019-951@post.gmane.org>
	 <loom.20090113T150220-345@post.gmane.org>
	 <496CD49D.1070201@drmicha.warpmail.net>
	 <loom.20090113T185918-397@post.gmane.org>
	 <20090113203922.GD30404@atjola.homenet>
	 <loom.20090113T204616-845@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Vladimir Pouzanov" <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMqaL-0004zI-Qb
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbZAMVMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbZAMVMl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:12:41 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:10286 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbZAMVMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:12:40 -0500
Received: by rv-out-0506.google.com with SMTP id k40so179187rvb.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QB2z80DuevHfkoqkm7ZRosjCBhYIJKggo+H5GxpxVP4=;
        b=os4/kgerRJPE+YeJwVUEz3YapPFRA+o5S0BpHggrAyFzLEG+ee8asG0f5CGvXeA7OM
         qdlVXxNP+u76tI2PWETU4U7tyU5Deyupfjzbu1RLfMWViLOliUCOAAAa0jXJB2aW4GXh
         XFsFPBr2SilnQ5Fnn7fg3+IVlBi2YxsuDfGCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TeiiISYt2qAQ2aK5UKtxlDZvOAx+GIahADRy5wBxETs+EQF88H7x9cxFsBlPwzHj1w
         xrfyyGkbJpy2sM/u8xPGUEtY9Lr7JU0WE4FqZl8WRdWDO+Cv7DPKYUQEeVblkZVdQoSI
         Afy9I/5lR8VcmQ9LMlmPqaKJkifkrTqQqRvV8=
Received: by 10.141.44.13 with SMTP id w13mr15494760rvj.18.1231881158862;
        Tue, 13 Jan 2009 13:12:38 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Tue, 13 Jan 2009 13:12:38 -0800 (PST)
In-Reply-To: <loom.20090113T204616-845@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105534>

T24gVHVlLCBKYW4gMTMsIDIwMDkgYXQgMzo0NiBQTSwgVmxhZGltaXIgUG91emFub3YgPGZhcmNh
bGxlckBnbWFpbC5jb20+IHdyb3RlOgo+IEJqw7ZybiBTdGVpbmJyaW5rIDxCLlN0ZWluYnJpbmsg
PGF0PiBnbXguZGU+IHdyaXRlczoKPj4gSXMgdGhhdCBMaW51eCBib3ggdXNpbmcgR2VudG9vPyBJ
ZiBzbywgdHJ5IGVtZXJnaW5nIHN1YnZlcnNpb24gd2l0aCAtZHNvCj4+IGluIHlvdXIgYnVpbGQg
ZmxhZ3MuCj4KPiBZZWFoLCB0aGF0J3MgZ2VudG9vLiBXaWxsIHRyeSByZWJ1aWxkaW5nIHN2biBu
b3cuIEFueSBoaW50cyBhYm91dCBPU1gKPiBwZXJsIHByb2JsZW0/CgpZb3VyIG9yaWdpbmFsIGVt
YWlsIGRvZXNuJ3QgYXBwZWFyIHRvIHByb3ZpZGUgdGhlIGNvbXBsZXRlIGVycm9yCm1lc3NhZ2Uu
IEknbSBvbiBPUyBYIDEwLjUuNiAoSW50ZWwpLCBnaXQgMS42LjEuNzcuZzgxZWExLCBzeXN0ZW0g
cGVybAooL3Vzci9iaW4vcGVybCAtIDUuOC44KSBhbmQgSSdtIGFibGUgdG8gY2xvbmUgb2theToK
CiQgd2hpY2ggZ2l0Ci9vcHQvZ2l0L2Jpbi9naXQKJCBnaXQgdmVyc2lvbgpnaXQgdmVyc2lvbiAx
LjYuMS43Ny5nODFlYTEKJCBnaXQgc3ZuIGNsb25lIGh0dHA6Ly9xc2ItbWFjLmdvb2dsZWNvZGUu
Y29tL3N2bi90cnVuayBxc2ItbWFjCi4uLgpDaGVja2VkIG91dCBIRUFEOgogIGh0dHA6Ly9xc2It
bWFjLmdvb2dsZWNvZGUuY29tL3N2bi90cnVuayByMjEKCmouCg==
