From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-mailinfo: cut lines at ^M
Date: Mon, 16 Jan 2006 15:49:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601161548560.13339@g5.osdl.org>
References: <Pine.LNX.4.64.0601161104070.13339@g5.osdl.org>
 <7v1wz7n3oz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 17 00:49:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eye6c-0006sk-Hd
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 00:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWAPXto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWAPXto
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 18:49:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751269AbWAPXtn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 18:49:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0GNnaDZ022598
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Jan 2006 15:49:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0GNnZxT015304;
	Mon, 16 Jan 2006 15:49:35 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wz7n3oz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14769>



On Mon, 16 Jan 2006, Junio C Hamano wrote:
> 
> I've briefly wondered if a better alternative is to split lines
> at "\r\n", "\n", or "\r", which would make the next line begin
> with ")" in your example.

In which case the patch does nothing good for me. I want to either drop 
the bogus line, or have applymbox refuse to apply such an email..

		Linus
