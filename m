From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Mon, 11 Nov 2013 22:34:43 +0100
Message-ID: <52814D73.4010706@web.de>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de> <loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Ari Pollak <ari@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 22:34:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfz8E-00081o-6D
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 22:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab3KKVeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 16:34:46 -0500
Received: from mout.web.de ([212.227.17.12]:65092 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab3KKVep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 16:34:45 -0500
Received: from [192.168.178.41] ([91.3.132.224]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MDgLi-1Vx4gP3kq6-00HAv6 for <git@vger.kernel.org>;
 Mon, 11 Nov 2013 22:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52814C35.6040205@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:7OhMQl+s8H8pnDrwqmCaPmljLzBR3FrGLxbovf8Fxz4dv56UoM3
 RVQbktvQGETeoXZe5SSqb1F5ZGDPlxunZPjYwo5V3bkhwxy5F5MN3g/uVOhkWSQmjOWD3rV
 7xDuTSyc0Z6u/Txw8FKB4NiitxOEw5kVnlIU33vibDoUfwvu8Lx4g5oOI3ZobnzT9Hu0KxJ
 mDL5ZleDv3pk+zKWQ8GNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237660>

Am 11.11.2013 22:29, schrieb Jens Lehmann:
> And while testing this issue I noticed another problem: When using
> "git commit -a" not only the staged commits of a submodule get
> committed, but also the unstaged commits. Will look into that too.

Ok, scrap that. This is exactly what is expected.
