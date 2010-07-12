From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 11
Date: Mon, 12 Jul 2010 16:35:46 +0200
Message-ID: <20100712143546.GA17630@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Greg Stein <gstein@gmail.com>, Stefan Sperling <stsp@elego.de>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Huijben <rhuijben@collab.net>,
	Sam Vilain <sam@vilain.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 12 16:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYK5F-0005n7-55
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 16:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab0GLOeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 10:34:06 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64944 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab0GLOeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 10:34:04 -0400
Received: by ewy23 with SMTP id 23so838308ewy.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=sEljtBhnYTRjDGgodIdV9g323+SfwNFFiHrguRw9K+M=;
        b=VIe1WQ4lZXiHsWRLO2eOvzxG3CSCnOp9RZVgHvPQ3KnvmDA+W/qa6uZll7EUJrK9Sj
         2wCVgr6ac8BrYbElssO39ra/XfwP24ouQx//uet4/xW8lc87xEorBSPWuGq7qfOMJZfN
         6ePHAkGHagcYzCNlCK5WFyF7aQbcd5uzcMAZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=JEJmzShXwm/kP/kJp6HYPtvsCQezYYC3qn4wmgZAA1On1KTjn0g712p1VdvYta2clm
         tJ6qubA3k4D8FkssxeGDJN2VeW3DoD3LY9vt4meG4o+Cda/DXGUtG2+/PxYAEa2YIE/J
         7dyUt19xEi8AYVDiXiXlw1u7QoiTlcWFmjpLc=
Received: by 10.213.19.207 with SMTP id c15mr1396865ebb.76.1278945242967;
        Mon, 12 Jul 2010 07:34:02 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm37640215eei.13.2010.07.12.07.33.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 07:33:59 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150815>

Hi,

I'm happy to report that I'll soon be getting partial committer access
to the ASF repository (thanks to Greg for this) and will be able to
commit the svnrdump there. At the moment, all the validations pass
without any issues and I've shifted my focus towards writing a
dumpfile v3 parser [1] to get the data into David's exporter. I will
re-roll a series for git.git in some time again after I've fixed a few
pending things pointed out by Jonathan in his excellent reviews and
merged a few patches from Will; although this isn't top priority, it
will be pretty painful for Git developers to compile the SVN trunk
even if they want to try out git-remote-svn.

Currently, I'm implementing svndiff0 parser component of the dumpfile
v3 parser using Sam's Perl implementation [2] as a guideline. In
addition, with an excellent specification present in the Subversion
trunk [3], this shouldn't be a problem.

-- Ram

[1]: dumpfilev3 branch of
http://github.com/artagnon/svn-dump-fast-export/
[2]: http://search.cpan.org/~samv/Parse-SVNDiff/
[3]: http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff
