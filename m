From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 05/12] MINGW: git-compat-util.h: use inttypes.h for
 printf macros.
Date: Mon, 28 Apr 2014 19:00:57 +0400
Message-ID: <20140428150057.GA19002@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-6-git-send-email-marat@slonopotamus.org>
 <CABPQNSaP=q5Y4oKOM3zAMvhATZx2BDj_8s6ZO1EBFPGrtSj1Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:01:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wen47-0002GB-M6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbaD1PBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:01:23 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:37942 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbaD1PBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:01:17 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wen3B-0004xf-ML; Mon, 28 Apr 2014 19:00:57 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSaP=q5Y4oKOM3zAMvhATZx2BDj_8s6ZO1EBFPGrtSj1Tw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247350>

On Mon, Apr 28, 2014 at 04:53:52PM +0200, Erik Faye-Lund wrote:
> Just checking that I understand: Does this mean that we now require an
> MSVC-version that has stdint.h? If so, I'm not against such a case.
> IMO, the biggest benefit of using MSVC is not building on legacy
> systems, but being able to use it's debugger. And for that purpose
> it's probably OK to increase the required version.

Ouch, that was not intentional. What minimal MSVC version is currently
supported and who decides if it is OK to increase required one?
