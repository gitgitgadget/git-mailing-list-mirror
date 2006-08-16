From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb / cg-export
Date: Thu, 17 Aug 2006 00:50:08 +0200
Message-ID: <1155768608.3386.1.camel@pim.off.vrfy.org>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org>
	 <44E2F911.6060002@gmail.com>  <20060816224000.GE14459@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 00:50:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDUD1-0004Pw-I7
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 00:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWHPWt4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 18:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWHPWt4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 18:49:56 -0400
Received: from soundwarez.org ([217.160.171.123]:24728 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751032AbWHPWtz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 18:49:55 -0400
Received: from noname (e179197007.adsl.alicedsl.de [85.179.197.7])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 19517ABAA2;
	Thu, 17 Aug 2006 00:49:54 +0200 (CEST)
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060816224000.GE14459@admingilde.org>
X-Mailer: Evolution 2.6.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25539>

On Thu, 2006-08-17 at 00:40 +0200, Martin Waitz wrote:
> hoi :)
> 
> On Wed, Aug 16, 2006 at 04:23:05PM +0530, Aneesh Kumar K.V wrote:
> > @@ -1334,6 +1335,7 @@ sub git_shortlog_body {
> >  		      "<td class=\"link\">" .
> >  		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
> >  		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
> > +		      " | " .$cgi->a({-href => "$my_uri/$project.tar.gz?" . esc_param("p=$project;a=snapshot;h=$commit")}, "snapshot") .
> >  		      "</td>\n" .
> >  		      "</tr>\n";
> >  	}
> 
> Isn't there some other way to tell the webbroser how to name the file?
> I thought there is some HTML header to explicitly give one file name.

Something like in line 1923?
  $cgi->header(-type => "$type", '-content-disposition' => "inline; filename=\"$save_as\"");

Kay
