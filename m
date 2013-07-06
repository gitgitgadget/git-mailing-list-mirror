From: Daniel Shahaf <danielsh@apache.org>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and
 skelta mode
Date: Sat, 6 Jul 2013 02:04:07 +0000
Message-ID: <20130706020407.GA26200@minotaur.apache.org>
References: <kr6uvc$p8a$1@ger.gmane.org>
 <51D7072A.6080909@wandisco.com>
 <kr75h0$qg5$1@ger.gmane.org>
 <51D7362B.1040803@wandisco.com>
 <kr7il5$n0p$1@ger.gmane.org>
 <51D7660F.6070901@wandisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: wSubversion Development <dev@subversion.apache.org>,
	git@vger.kernel.org
To: Branko =?utf-8?B?xIxpYmVq?= <brane@wandisco.com>
X-From: dev-return-27431-gcvsd-dev=m.gmane.org@subversion.apache.org Sat Jul 06 04:04:11 2013
Return-path: <dev-return-27431-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@plane.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-27431-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1UvHr7-0007ut-Hy
	for gcvsd-dev@plane.gmane.org; Sat, 06 Jul 2013 04:04:09 +0200
Received: (qmail 45474 invoked by uid 500); 6 Jul 2013 02:04:08 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 45465 invoked by uid 99); 6 Jul 2013 02:04:08 -0000
Received: from minotaur.apache.org (HELO minotaur.apache.org) (140.211.11.9)
    by apache.org (qpsmtpd/0.29) with ESMTP; Sat, 06 Jul 2013 02:04:08 +0000
Received: by minotaur.apache.org (Postfix, from userid 3316)
	id 0BB96108E2; Sat,  6 Jul 2013 02:04:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51D7660F.6070901@wandisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229688>

On Sat, Jul 06, 2013 at 02:34:23AM +0200, Branko Čibej wrote:
> http://subversion.apache.org/docs/release-notes/1.7.html#svnrdump
> In other words, this is a limitation of the Serf-based backend that has
> been around since Subversion 1.4. I'm aware that it isn't documented as
> well as it should be, but the bulk-mode workaround exists in part as a
> workaround for that, effectively disabling the more efficient HTTPv2
> protocol.

Is it possible to set "SVNAllowBulkUpdates Prefer" on a per-client basis?

That would require two things: (1) for git-svn to identify itself as such via
the User-Agent string, (2) for httpd to support making the SVNAllowBulkUpdates
directive conditional on a request header.
