From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Wed, 09 Aug 2006 22:54:42 +0200
Organization: At home
Message-ID: <ebdi1v$cv5$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <ebauq1$kcb$1@sea.gmane.org> <7vu04mucaq.fsf@assigned-by-dhcp.cox.net> <ebb3fm$2md$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 09 22:54:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAv4m-0006WU-UK
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 22:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWHIUyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWHIUyu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 16:54:50 -0400
Received: from main.gmane.org ([80.91.229.2]:39564 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751326AbWHIUyt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 16:54:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAv4d-0006UG-Kx
	for git@vger.kernel.org; Wed, 09 Aug 2006 22:54:43 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 22:54:43 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 22:54:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25145>

Subroutines in gitweb: <current name> => <proposed rename>.
If nobody would give any better suggestions, or warn about patches to gitweb
to be sent, could we do that "Great subroutines renaming" some time soon?
TIA.

* validate_input
* esc_param
* esc_html
* unquote
* untabify
* chop_str

* age_class
* age_string
* mode_str
* file_type

* format_log_line_html
* git_get_referencing => format_mark_referencing (???)

* git_read_head => git_get_head_hash
* git_read_hash => git_get_hash_by_ref
* git_get_hash_by_path
* git_get_type
* git_get_project_config
* git_get_project_config_bool
* git_read_description => git_get_project_description
* git_read_projects => git_get_projects_list
* read_info_ref => git_get_references
* git_read_refs => git_get_refs_list

* date_str => parse_date
* git_read_tag => parse_tag
* git_read_commit => parse_commit

* get_file_owner
* mimetype_guess_file => ??? (reads, parses and uses mime.types like file)
* mimetype_guess => (to be incorporated in blob_mimetype)
* git_blob_plain_mimetype => blob_mimetype
* git_get_paging_nav => ???
* git_page_nav => git_print_page_nav
* git_header_div => git_print_header_div
* git_print_page_path
* git_diff_print => (to be made obsolete)

* git_header_html
* git_footer_html
* die_error

* git_shortlog_body
* git_tags_body
* git_heads_body

* git_project_list
* git_summary
* git_tag
* git_blame2 => git_blame (?)
* git_blame => git_annotate (?)
* git_tags
* git_heads
* git_blob_plain
* git_blob
* git_tree
* git_log
* git_commit
* git_blobdiff
* git_blobdiff_plain
* git_commitdiff
* git_commitdiff_plain
* git_history
* git_search
* git_shortlog
* git_rss
* git_opml

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
