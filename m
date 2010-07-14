From: "C. Michael Pilato" <cmpilato@collab.net>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 13:56:14 -0400
Organization: CollabNet, Inc.
Message-ID: <4C3DFA3E.7000809@collab.net>
References: <20100709142910.GB20383@debian> <20100713201105.GN13310@ted.stsp.name> <20100714153206.GH25630@jack.stsp.name> <20100714160149.GA7561@debian> <20100714172429.GC25861@ted.stsp.name> <4C3DF456.20803@collab.net> <20100714174716.GB2866@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 19:56:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ6C0-0003e4-2S
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab0GNR4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:56:18 -0400
Received: from sp-exchfea.sp.corp.collab.net ([204.16.106.198]:14364 "EHLO
	sp-exchfea.sp.corp.collab.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753692Ab0GNR4R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 13:56:17 -0400
Received: from [204.11.125.142] ([204.11.125.142]) by sp-exchfea.sp.corp.collab.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jul 2010 10:56:16 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
In-Reply-To: <20100714174716.GB2866@burratino>
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 14 Jul 2010 17:56:17.0078 (UTC) FILETIME=[DB819D60:01CB237D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151024>

On 07/14/2010 01:47 PM, Jonathan Nieder wrote:
> C. Michael Pilato wrote:
> 
>> Revprops aren't handled by the replay API for any revision.
> 
> Hmm?  What is the rev_props argument to the
> 
> typedef svn_error_t (*svn_ra_replay_revstart_callback_t)(
> 				svn_revnum_t revision,
> 				void *replay_baton,
> 				const svn_delta_editor_t **editor,
> 				void **edit_baton,
> 				apr_hash_t *rev_props,
> 				apr_pool_t *pool)
> 
> callback for, then?
> 
> Using svn_ra_rev_prop() for rev 0 does seem simple enough, though.

Ah, I was talking about the svn_repos_replay() API (which is used by the
svn_ra_replay() API).  It definitely makes sense to me that the RA's replay
API be able to report the revprops for revision 0.

Sorry for the confusion.

-- 
C. Michael Pilato <cmpilato@collab.net>
CollabNet   <>   www.collab.net   <>   Distributed Development On Demand
