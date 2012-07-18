From: baluchen <murugan.bala@gmail.com>
Subject: Re: clone URL missing in gitweb
Date: Wed, 18 Jul 2012 01:30:20 -0700 (PDT)
Message-ID: <1342600220487-7563196.post@n2.nabble.com>
References: <1342591638170-7563176.post@n2.nabble.com> <20120718085853.1702340b2uu0gmnh@webmail.moger.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 10:30:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrPeQ-0005sM-8V
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 10:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab2GRIaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 04:30:25 -0400
Received: from sam.nabble.com ([216.139.236.26]:52992 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902Ab2GRIaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 04:30:21 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <murugan.bala@gmail.com>)
	id 1SrPeG-00040C-GV
	for git@vger.kernel.org; Wed, 18 Jul 2012 01:30:20 -0700
In-Reply-To: <20120718085853.1702340b2uu0gmnh@webmail.moger.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201670>

Thanks tom. 

I verified and i have following line in my gitweb.cgi. But still i caould
not get cloan

our @git_base_url_list = grep { $_ ne '' } ("");
        @url_list = map { "$_/$project" } @git_base_url_list unless
@url_list;

        # use per project git URL list in $projectroot/$project/cloneurl
        # or make project git URL from git base URL and project name
        my $url_tag = "URL";
        my @url_list = git_get_project_url_list($project);
        @url_list = map { "$_/$project" } @git_base_url_list unless
@url_list;
        foreach my $git_url (@url_list) {
                next unless $git_url;
                print format_repo_url($url_tag, $git_url);
                $url_tag = ""; 
        }



Thanks
Bala

--
View this message in context: http://git.661346.n2.nabble.com/clone-URL-missing-in-gitweb-tp7563176p7563196.html
Sent from the git mailing list archive at Nabble.com.
