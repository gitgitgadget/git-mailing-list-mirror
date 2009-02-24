From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 0/3] --format, --pretty and --oneline
Date: Tue, 24 Feb 2009 18:59:13 +0900
Message-ID: <20090224185913.6117@nanako3.lavabit.com>
References: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com> <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org> <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com> <7vljrxveqa.fsf@gitster.siamese.dyndns.org> <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com> <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com> <7v3ae4r53f.fsf@gitster.siamese.dyndns.org> <20090224130626.6117@nanako3.lavabit.com> <20090224045041.GA4615@coredump.intra.peff.net> <7vprh8mm9k.fsf@gitster.siamese.dyndns.org> <20090224054524.GE4615@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	felipe.contreras@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 11:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbuA8-0005UU-VY
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 11:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbZBXKDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 05:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbZBXKDq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 05:03:46 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58793 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbZBXKDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 05:03:45 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 3D9A111B8DB;
	Tue, 24 Feb 2009 04:03:44 -0600 (CST)
Received: from 2293.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 5FS9SE3AVN8K; Tue, 24 Feb 2009 04:03:44 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Tb92ZdEK3JyEOcRwzAPAnRJdW71UlDWinHWieBDYuN3OnvreZdyiTVhLEEgIOL6b+tHEhpIedUySGi9Yt5LWZI5TCavGCsmQvy1BJWy5XlNUE9pNynZmWx0Pr8afBZfa7ApJDcgKAOHWlodUGtI2km9P1kviZlD2lOEXyJrfXdw=;
  h=From:To:cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <20090224054524.GE4615@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111278>

As suggested by Jeff and Junio, this splits my patch into two and
implements --oneline as a synonym for --pretty=oneline --abbrev-commit.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
