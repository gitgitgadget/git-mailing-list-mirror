From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 00:34:44 -0400
Message-ID: <20130609043444.GA561@sigill.intra.peff.net>
References: <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
 <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
 <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
 <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
 <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
 <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 06:35:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlXLM-0001cS-B4
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 06:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab3FIEer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 00:34:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:59879 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab3FIEer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 00:34:47 -0400
Received: (qmail 10320 invoked by uid 102); 9 Jun 2013 04:35:36 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Jun 2013 23:35:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 00:34:44 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226879>

On Sat, Jun 08, 2013 at 09:20:54AM -0500, Felipe Contreras wrote:

> Let the code speak. Show me a script in any language that does
> something useful using libgit2, doing the equivalent to at least a
> couple of 'git foo' commands.

Sorry that I cannot show you the source code, but you may interested to
know that libgit2 powers:

  1. Microsoft's "Visual Studio Tools for Git" plugin

  2. GitHub's native Mac and Windows clients (using Objective C and C#
     bindings); some operations still shell out to git where the
     functionality is not yet implemented in libgit2.

  3. Parts of the web view of GitHub.com via Ruby bindings

It is definitely not feature-complete when compared with git.git. But I
do think it is in a state that is usable for quite a few tasks.

-Peff
