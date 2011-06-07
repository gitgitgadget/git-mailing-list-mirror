From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
	/etc/gitweb.conf (WIP)
Date: Tue, 07 Jun 2011 15:50:29 -0400
Message-ID: <1307476229.12888.86.camel@drew-northup.unet.maine.edu>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
	 <7vtyc160ha.fsf@alter.siamese.dyndns.org>
	 <1307468628.12888.81.camel@drew-northup.unet.maine.edu>
	 <201106072136.03964.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU2J2-0002hv-3V
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab1FGTvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:51:10 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:51146 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab1FGTvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:51:09 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p57JoYgj004740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jun 2011 15:50:34 -0400
In-Reply-To: <201106072136.03964.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=6 Fuz1=6
	Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p57JoYgj004740
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1308081041.20646@JoNo6tuC3BPSuqhI0DJF6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175261>

On Tue, 2011-06-07 at 21:36 +0200, Jakub Narebski wrote:
> Anyway, because of backward compatibility (bug-compatible) we have to
> name new system-wide config file /etc/gitweb-common.conf, fallback config
> be at /etc/gitweb.conf, and per-instance config file gitweb_config.perl
> Note that these are only defaults; they can be overridden at build time
> (though you cannot change names of respective environmental variables).
> 
> Perhaps at some flag day (1.8.0 is probably to close) we can change it so
> that system-wide config file is /etc/gitweb.conf, per-instance config file
> (overriding system-wide settings) is gitweb_config.perl, and fallback
> system-installed config file used if per-instance config file does not
> exists is /etc/gitweb_config.perl

I would not have asked that such a large change happen any sooner than
that.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
