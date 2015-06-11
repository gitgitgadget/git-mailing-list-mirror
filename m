From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow to control the namespace for replace refs
Date: Fri, 12 Jun 2015 05:46:11 +0900
Message-ID: <20150611204611.GA10114@glandium.org>
References: <1433987235-17385-1-git-send-email-mh@glandium.org>
 <xmqqlhfqhmil.fsf@gitster.dls.corp.google.com>
 <20150611051339.GA3637@glandium.org>
 <xmqq1thigtsd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:46:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z39Ml-0000mZ-N8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 22:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbbFKUqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 16:46:20 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:42875 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbbFKUqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 16:46:19 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Z39MZ-0002eT-UF; Fri, 12 Jun 2015 05:46:11 +0900
Content-Disposition: inline
In-Reply-To: <xmqq1thigtsd.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271462>

On Thu, Jun 11, 2015 at 08:16:02AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > I do agree that this is all confusing, but allow me to point out that
> > it's already plenty confusing: "namespace" is a term that has been used to
> > designate a generic kind of namespace *and* refs/namespaces. See for
> > example:
> >
> > https://github.com/git/git/blob/master/Documentation/git-describe.txt#L39
> > https://github.com/git/git/blob/master/Documentation/git-fetch.txt#L113
> > https://github.com/git/git/blob/master/Documentation/git-filter-branch.txt#L36
> > (note how this one is specifically about refs/replace/)
> > there are many more.
> 
> "One more breakage does not hurt" is not something we want to see.

I won't disagree here, but we are in desperate need for a word for those
namespaces that aren't refs/namespaces, and stick to it (independently
of the replace patch), but I've never seen one.

Mike
