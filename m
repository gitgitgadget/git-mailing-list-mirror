From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 07/12] MINGW: config.mak.uname: reorganize MINGW settings
Date: Mon, 28 Apr 2014 19:04:36 +0400
Message-ID: <20140428150436.GB19002@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-8-git-send-email-marat@slonopotamus.org>
 <CABPQNSb_+hrm-avwx4Y1749C_Ak4VN5KKvso3LeFcdDPcbqS5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:05:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wen7A-0005xT-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbaD1PE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:04:58 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:41401 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbaD1PEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:04:54 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wen6i-0004yW-Rh; Mon, 28 Apr 2014 19:04:37 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSb_+hrm-avwx4Y1749C_Ak4VN5KKvso3LeFcdDPcbqS5w@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247352>

On Mon, Apr 28, 2014 at 04:58:11PM +0200, Erik Faye-Lund wrote:
> On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> > HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
> > msysGit, they're general MinGW settings.
> 
> Actually, HAVE_LIBCHARSET_H is. It's only present because we have
> libiconv installed.

1. What are other ways to provide iconv on MinGW?
2. One can still completely disable iconv with NO_ICONV=1
