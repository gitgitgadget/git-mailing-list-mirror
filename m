From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v4 5/6] format-patch: add format.cover-letter
 configuration
Date: Sun, 7 Apr 2013 21:34:16 +0200
Message-ID: <20130407193415.GB13708@ruderich.org>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
 <1365356784-24872-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p1-0000sy-5E
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933229Ab3DGTeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:34:20 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:60597 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933185Ab3DGTeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:34:19 -0400
Received: from localhost (p54B5FDE7.dip.t-dialin.net [::ffff:84.181.253.231])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Sun, 07 Apr 2013 21:34:16 +0200
  id 00000000000000AC.000000005161CA38.00007010
Content-Disposition: inline
In-Reply-To: <1365356784-24872-6-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220372>

On Sun, Apr 07, 2013 at 12:46:23PM -0500, Felipe Contreras wrote:
> [snip]
>
> +test_expect_success 'cover letter auto' '
> +	mkdir -p tmp &&
> +	test_when_finished "rm -rf tmp;
> +		git config --unset format.coverletter" &&
> +
> +	git config format.coverletter auto &&

    test_config format.coverletter auto &&

takes automatically care of the git config --unset cleanup.

I'm not sure if it's better to use test_when_finished with rm or
just && rm -rf tmp at the end of the test in case someone wants
to look at the output.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
