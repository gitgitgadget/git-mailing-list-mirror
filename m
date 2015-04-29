From: Ed Avis <eda@waniasset.com>
Subject: Re: 'git show' with multiple revisions
Date: Wed, 29 Apr 2015 16:01:41 +0000 (UTC)
Message-ID: <loom.20150429T175626-211@post.gmane.org>
References: <loom.20150428T120412-982@post.gmane.org> <20150429020452.GA873@peff.net> <loom.20150429T174544-7@post.gmane.org> <xmqqtwvz53t7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 18:02:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnURE-0003BR-A0
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 18:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031379AbbD2QCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 12:02:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:53802 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966000AbbD2QCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 12:02:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YnUQu-0002tH-EV
	for git@vger.kernel.org; Wed, 29 Apr 2015 18:01:56 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 18:01:56 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 18:01:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:36.0) Gecko/20100101 Firefox/36.0 Cyberfox/36.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267980>

Junio C Hamano <gitster <at> pobox.com> writes:

>"cat-file --batch" will give you the objects in the order you ask.

Thanks, that makes it easy to deal with.  In fact, I might prefer to use
git cat-file --batch-check and then use some other library to fetch the blob
contents.

-- 
Ed Avis <eda@waniasset.com>
