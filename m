From: Andreas Ericsson <exon@op5.com>
Subject: Re: How can I tell if a tag has been pushed, or not?
Date: Sat, 11 Jul 2009 15:44:53 +0200
Message-ID: <4A589755.2020600@op5.com>
References: <14563.1247247807@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Sat Jul 11 15:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPct1-0006Fg-8n
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 15:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbZGKNo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 09:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZGKNo5
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 09:44:57 -0400
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46831 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751133AbZGKNo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2009 09:44:57 -0400
Received: from source ([74.125.78.25]) by na3sys009aob107.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSliXVlJNNVhEP+Q8TTcvNr7lPcJ1ecWO@postini.com; Sat, 11 Jul 2009 06:44:56 PDT
Received: by ey-out-2122.google.com with SMTP id 9so303098eyd.53
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 06:44:54 -0700 (PDT)
Received: by 10.210.43.11 with SMTP id q11mr1005861ebq.53.1247319894113;
        Sat, 11 Jul 2009 06:44:54 -0700 (PDT)
Received: from ?192.168.25.19? (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 7sm1554121eyg.8.2009.07.11.06.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Jul 2009 06:44:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <14563.1247247807@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123112>

layer wrote:
> Here's the problem:
> 
> I expect that users, in their own private repos, will from time to
> time create tags that should not be pushed.  Sometimes, tags that
> should be pushed will be created.
> 
> I could require that the "public" tags follow a specific convention
> (start with "release", or something).  Then, the scripts all my
> developers use could use that and push only certain tags.  However,
> over time there could be a large number of them.  It seems undesirable
> to push each tag each time a push is done.  So, how can I tell if a
> tag has already been pushed?  Is there a way?
> 

At $dayjob we only allow annotated tags to be pushed. The default
update hook works like a charm for that. All private tags are kept
un-annotated and can therefore never be pushed by accident.

/Andreas
