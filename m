From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] fast-import: add options to enable/disable case folding
Date: Sat, 18 Apr 2015 16:36:11 +0900
Message-ID: <20150418073611.GA13410@glandium.org>
References: <xmqqoarclgnr.fsf@gitster.dls.corp.google.com>
 <1429271526-31234-1-git-send-email-mh@glandium.org>
 <55313B4B.3030106@web.de>
 <xmqqwq1appcf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 09:36:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjNJ8-0002P7-2L
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 09:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbDRHgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 03:36:36 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47313 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbbDRHgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 03:36:35 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YjNIR-0003bp-L6; Sat, 18 Apr 2015 16:36:11 +0900
Content-Disposition: inline
In-Reply-To: <xmqqwq1appcf.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267407>

On Fri, Apr 17, 2015 at 11:44:00AM -0700, Junio C Hamano wrote:
> So perhaps we should rip the case folding out altogether instead?
> The entry for the change in the Release Notes may say:
> 
>  * "git fast-import" incorrectly case-folded the paths recorded in
>    the history when core.ignorease is set (i.e. the repository's
>    working tree is incapable of expressing paths that differ only in
>    their cases); this old bug was reported in 2012 and was finally
>    corrected.
> 
> or something like that?

Is anything else then git-p4 known to rely on case folding? If not, I
guess that's a reasonable plan. We could even add an option to
fast-import that would allow to turn case folding back on, and make
git-p4 use it, so that its expectations are fulfilled. Although at some
point, it could (should?) do case folding itself(?)

Mike
