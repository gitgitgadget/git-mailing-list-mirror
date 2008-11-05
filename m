From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Referring to a submodule state recorded in a supermodule from within the submodule
Date: Wed, 5 Nov 2008 19:09:51 +0100
Message-ID: <200811051909.51970.johan@herland.net>
References: <200811051824.28374.johan@herland.net> <7vhc6mkqxb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 19:11:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxmqr-0000Mv-Ov
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 19:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYKESKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 13:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbYKESKN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 13:10:13 -0500
Received: from sam.opera.com ([213.236.208.81]:50365 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865AbYKESKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 13:10:12 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id mA5I9qWs008648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Nov 2008 18:09:52 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vhc6mkqxb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100170>

On Wednesday 05 November 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > I have a stand-alone project, "foo", that I work on myself. The
> > "foo" project is included as a submodule in two other projects,
> > "bar" and "baz", that I don't have any direct affiliation with.
> >
> > Semi-regularly, I like to keep tabs on bar and baz, to see what
> > versions of foo they are using, what changes they have made to foo,
> > and if there are things I could pick up from them, or maybe even
> > things they could learn from eachother.
> >
> > Doing this currently is quite tedious:
> > 1. Clone/Fetch bar and initialize/update its foo submodule
> > 2. Clone/Fetch baz and initialize/update its foo submodule
>
> If I am reading you right and you are only interested in the part
> "foo" in these projects, there is something wrong with the setup of
> "bar" and "baz".
>
> The submodule mechanism is designed to bind an independent project on
> its own as a subdirectory of another project.  It seems to me that
> the problem is that "bar" and "baz" projects do not give direct
> access to clone "foo" part of them for you or other people.

No, they do. I can clone foo directly from bar/baz's server. The problem 
is that I cannot quickly get at which revision of foo is used by 
bar/baz without tedious cloning and interacting with the superrepos.

I basically want to quickly answer questions like "What are the 
differences between bar's foo and baz's foo (and my own foo)?"


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
