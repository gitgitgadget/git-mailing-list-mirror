From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: how to name main "action" subroutines?
Date: Mon, 31 Jul 2006 20:45:22 +0200
Organization: At home
Message-ID: <ealj3h$to2$1@sea.gmane.org>
References: <eal2ic$14o$1@sea.gmane.org> <200607312038.44337.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 20:47:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7cm9-0004Mk-8r
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWGaSp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 14:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWGaSp6
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 14:45:58 -0400
Received: from main.gmane.org ([80.91.229.2]:58322 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030279AbWGaSp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 14:45:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7clz-0004KU-P8
	for git@vger.kernel.org; Mon, 31 Jul 2006 20:45:51 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 20:45:51 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 20:45:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24535>

Josef Weidendorfer wrote:

> On Monday 31 July 2006 16:03, you wrote:
>> I'm going to rename some gitweb subroutines to better correspond to what
>> given subroutine does. I have problem: how to name main "action"
>> subroutines? Currently they use git_ prefix, e.g. git_logo.
>> git_project_list, git_rss, git_summary, git_heads,...
> 
> print_* or write_* ?
> At least, the functions print/write the HTML code to stdout of the script.

The problem is that there are subroutines which print _fragments_ of HTML
code (like git_header_html or git_print_page_path) which would use probably
print_ prefix. Action subroutines output always whole page.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
