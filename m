From: Bernt Hansen <bernt@norang.ca>
Subject: Re: [PATCH] Clarify git-format-patch --in-reply-to
Date: Fri, 19 Dec 2008 17:01:04 -0500
Organization: Norang Consulting Inc
Message-ID: <87bpv77rkv.fsf@gollum.intra.norang.ca>
References: <7vzlitho1o.fsf@gitster.siamese.dyndns.org>
	<87k59wc73n.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 23:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDnta-000404-4n
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 23:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYLSWbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 17:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYLSWbP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 17:31:15 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:58817 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbYLSWbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 17:31:14 -0500
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Dec 2008 17:31:14 EST
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1LDnPA-000DNp-1b; Fri, 19 Dec 2008 22:01:08 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id mBJM14WY028465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Dec 2008 17:01:06 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id mBJM14k5011848;
	Fri, 19 Dec 2008 17:01:04 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id mBJM14q9011846;
	Fri, 19 Dec 2008 17:01:04 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19XiYbwAZCAxtiBbRP3B+H2
In-Reply-To: <87k59wc73n.fsf@jidanni.org> (jidanni@jidanni.org's message of "Sat\, 20 Dec 2008 03\:12\:12 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.95 http://www.acme.com/software/spfmilter/ with libspf2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103592>

jidanni@jidanni.org writes:

> Signed-off-by: jidanni <jidanni@jidanni.org>
>
> diff --git a/git-format-patch.txt b/git-format-patch.txt
> index ee27eff..04958de 100644
> --- a/git-format-patch.txt
> +++ b/git-format-patch.txt
> @@ -130 +130,2 @@ include::diff-options.txt[]
> -	provide a new patch series.
> +	provide a new patch series. Generates coresponding References and
                                              ^^^^^^^^^^^^
Typo                                          corresponding
> +	In-Reply-To headers. Angle brackets around <Message-Id> are optional.
> -- 
> 1.5.6.5
