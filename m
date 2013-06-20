From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 5/5] git-remote-mediawiki: Add preview subcommand into git mw.
Date: Thu, 20 Jun 2013 10:53:56 +0200
Message-ID: <vpqip19duxn.fsf@anie.imag.fr>
References: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
	<1371712593-6210-6-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 20 10:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upad4-0005g6-H3
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077Ab3FTIyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:54:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59817 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965007Ab3FTIx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 04:53:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5K8rtFw006837
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Jun 2013 10:53:55 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Upacu-0006NF-Ke; Thu, 20 Jun 2013 10:53:56 +0200
In-Reply-To: <1371712593-6210-6-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 20 Jun 2013 09:16:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Jun 2013 10:53:55 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228465>

benoit.person@ensimag.fr writes:

> +# @TODO : add documentation for verbose option

I guess that's not applicable anymore.

> +distant mediawiki and combined with a template retrieved from the mediawiki.

s/distant/remote/

> +sub preview {
> +	my $wiki;
> +	my ($remote_url, $wiki_page_name);
> +	my ($new_content, $template);
> +	my $file_content;
> +
> +	if ($file_name eq EMPTY) {
> +		die "Missing file argument, see `git mw help` \n";

Unneeded space before \n.

> +	for (@{ $html_tree->extract_links() }) {
> +		my ($link, $element, $attr) = @{ $_ };
> +		my $url = url($link)->canonical;
> +		$element->attr($attr, URI->new_abs($url, $remote_url));
> +	}

Extracting this into a function like "make_links_absolute" would have
made it clearer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
