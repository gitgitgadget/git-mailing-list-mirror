From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] move template_dir logic to configure script.
Date: Mon, 28 May 2007 23:46:47 -0700
Message-ID: <7vk5us6sa0.fsf@assigned-by-dhcp.cox.net>
References: <4658BDB0.9040501@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Tue May 29 08:47:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsvUT-0008ST-Vq
	for gcvg-git@gmane.org; Tue, 29 May 2007 08:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbXE2Gqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 02:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbXE2Gqt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 02:46:49 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45924 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbXE2Gqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 02:46:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070529064648.EKDP13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 May 2007 02:46:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4umn1X0041kojtg0000000; Tue, 29 May 2007 02:46:47 -0400
In-Reply-To: <4658BDB0.9040501@xs4all.nl> (Han-Wen Nienhuys's message of "Sat,
	26 May 2007 20:07:28 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48667>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> ---

Could I have at least three lines above the --- marker, please?

 (1) Defend _why_ this is a good change --- I would agree that
     this would make it more flexible, and I suspect that your
     main thrust with this is on some platforms (perhaps
     Windows?) you would want to have template_dir that is
     somewhere away from datarootdir.

 (2) an empty line between (1) and (3)

 (3) Signed-off-by: line.

>  config.mak.in |    2 +-
>  configure.ac  |    6 ++++++
>  2 files changed, 7 insertions(+), 1 deletions(-)
