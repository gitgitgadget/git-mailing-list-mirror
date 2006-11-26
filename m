X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Blake <ebb9@byu.net>
Subject: feature request - cg up as synonym for cg update
Date: Sat, 25 Nov 2006 22:19:45 -0700
Message-ID: <456923F1.8060209@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 05:22:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
X-Enigmail-Version: 0.94.1.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32330>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoCSk-0002ci-B1 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 06:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967297AbWKZFVl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 00:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935241AbWKZFVl
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 00:21:41 -0500
Received: from alnrmhc12.comcast.net ([204.127.225.92]:60567 "EHLO
 alnrmhc12.comcast.net") by vger.kernel.org with ESMTP id S935240AbWKZFVl
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 00:21:41 -0500
Received: from [192.168.0.103]
 (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225]) by comcast.net
 (alnrmhc12) with ESMTP id <20061126052140b1200mum3ve>; Sun, 26 Nov 2006
 05:21:40 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Coming from a CVS background, I am used to typing 'cvs up' instead of 'cvs
 update', and was surprised when 'cg up' didn't work as an obvious
counterpart.  According to 'cvs --help-synonyms', the complete list of
CVS's short synonyms:

$ cvs --help-synonyms
CVS command synonyms are:
        add          ad new
        admin        adm rcs
        annotate     ann
        checkout     co get
        commit       ci com
        diff         di dif
        export       exp ex
        history      hi his
        import       im imp
        log          lo
        login        logon lgn
        rannotate    rann ra
        rdiff        patch pa
        release      re rel
        remove       rm delete
        rlog         rl
        rtag         rt rfreeze
        status       st stat
        tag          ta freeze
        update       up upd
        version      ve ver

Many of these could probably be usefully implemented in cg, as one more
step for making life easy for converts from CVS to cogito.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFaSPw84KuGfSFAYARAtOHAJ9DFlOC23HSWCq7qbVwU+KuT6uIMwCgsWgJ
byVaSGuoaA6JWx9hi6y85y8=
=n12u
