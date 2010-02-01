From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Wishlist for branch management
Date: Sun, 31 Jan 2010 17:18:39 -0800
Message-ID: <4B662BEF.7040503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 02:18:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbkwD-0001QV-C9
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 02:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab0BABSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 20:18:44 -0500
Received: from terminus.zytor.com ([198.137.202.10]:34253 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab0BABSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 20:18:43 -0500
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by mail.zytor.com (8.14.3/8.14.3) with ESMTP id o111IdpG000412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 31 Jan 2010 17:18:43 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id o111IdXs013512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 31 Jan 2010 17:18:39 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id o111Idea022646;
	Sun, 31 Jan 2010 17:18:39 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138570>

A wishlist for better handling of branches:

git clone --branches

... git clone, with the additional step of setting up local branches for
each one of the remote branches.

git branch --current

... list the current branch name, for use in scripts.  Equivalent to:
	"git branch | grep '^\*' | cut -c3-"

git push --current

... push the current branch, and only the current branch...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
