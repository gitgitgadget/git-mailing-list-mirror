From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Announcement: cvs2svn 2.3.0 released
Date: Sun, 23 Aug 2009 00:44:23 +0200
Message-ID: <4A9074C7.4080002@alum.mit.edu>
Reply-To: users@cvs2svn.tigris.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Subversion Users <users@subversion.tigris.org>,        Git Mailing List <git@vger.kernel.org>,        Bazaar <bazaar@lists.canonical.com>
To: announce@cvs2svn.tigris.org
X-From: users-return-2386392+gcvscu-users=m.gmane.org@cvs2svn.tigris.org Sun Aug 23 00:44:36 2009
Return-path: <users-return-2386392+gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@m.gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=sc157-tigr.sjc.collab.net)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MezK5-0008D2-Ju
	for gcvscu-users@m.gmane.org; Sun, 23 Aug 2009 00:44:33 +0200
Received: from sc157-tigr.sjc.collab.net (localhost [127.0.0.1])
	by sc157-tigr.sjc.collab.net (Postfix) with ESMTP id CC2F3FCC172;
	Sat, 22 Aug 2009 15:44:32 -0700 (PDT)
Received: from localhost ([127.0.0.1])          by Mail Reader Service (JAMES SMTP Server 2.3.0) with SMTP ID 1000          for <users@cvs2svn.tigris.org.mrs>;          Sat, 22 Aug 2009 15:44:30 -0700 (PDT)
Received: from sc157-tigr.sjc.collab.net (localhost [127.0.0.1])	by sc157-tigr.sjc.collab.net (Postfix) with ESMTP id D03AFFCC060;	Sat, 22 Aug 2009 15:44:30 -0700 (PDT)
Received: from localhost ([127.0.0.1])          by Mail Reader Service (JAMES SMTP Server 2.3.0) with SMTP ID 408          for <announce@cvs2svn.tigris.org.mrs>;          Sat, 22 Aug 2009 15:44:29 -0700 (PDT)
Received: from cylon1.sjc.collab.net (cylon1.sjc.collab.net [204.16.104.10])	by sc157-tigr.sjc.collab.net (Postfix) with ESMTP id 5EC35FCC060	for <announce@cvs2svn.tigris.org>; Sat, 22 Aug 2009 15:44:29 -0700 (PDT)
Received: from einhorn.in-berlin.de ([192.109.42.8])  by cylon1.sjc.collab.net with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Aug 2009 15:44:28 -0700
Received: from [192.168.69.129] (p4FC1F051.dip.t-dialin.net [79.193.240.81])	(authenticated bits=0)	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n7MMiPbu026215	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Sun, 23 Aug 2009 00:44:26 +0200
List-Id: <users.cvs2svn.tigris.org>
Precedence: bulk
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkYDAAcSkErAbSoIgWdsb2JhbACbBAEBFiSoEYZJiEwVhAUFiBM
X-IronPort-AV: E=Sophos;i="4.44,258,1249282800";   d="scan'208";a="28180071"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126826>

I am happy to announce release 2.3.0 of cvs2svn/cvs2git/cvs2bzr.

cvs2svn is a tool for migrating a CVS repository to Subversion, git,
Bazaar, or Mercurial. The main design goals are robustness and 100% data
preservation. cvs2svn can convert just about any CVS repository we've
ever seen, including gcc, Mozilla, FreeBSD, KDE, and GNOME.

Release 2.3.0 primarily improves the support for converting to git and
Bazaar (including explicit cvs2git and cvs2bzr scripts).  This release
also adds a few other minor features and fixes a bug when converting to
git with non-inline blobs.

More detailed information is available in the CHANGES file [1].

Note to packagers: Beginning with this release, the man pages for the
main scripts are generated automatically by running the script with the
"--man" option (e.g., "cvs2svn --man >cvs2svn.1") or by executing "make
man".  The tarball does *not* include the man pages anymore.


You can get the tarball here:
http://cvs2svn.tigris.org/files/documents/1462/46528/cvs2svn-2.3.0.tar.gz

The MD5 checksum is 6c412baec974f3ff64b9145944682a15.

Please send any bug reports and comments to users@cvs2svn.tigris.org.

Michael

[1]
http://cvs2svn.tigris.org/source/browse/cvs2svn/tags/2.3.0/CHANGES?view=markup

------------------------------------------------------
http://cvs2svn.tigris.org/ds/viewMessage.do?dsForumId=1668&dsMessageId=2386391

To unsubscribe from this discussion, e-mail: [announce-unsubscribe@cvs2svn.tigris.org].

------------------------------------------------------
http://cvs2svn.tigris.org/ds/viewMessage.do?dsForumId=1670&dsMessageId=2386392

To unsubscribe from this discussion, e-mail: [users-unsubscribe@cvs2svn.tigris.org].
