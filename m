From: dave morgan <morgad@eclipse.co.uk>
Subject: problem installing latest cogito
Date: Sat, 21 Jan 2006 14:08:27 +0000
Organization: the great unwashed
Message-ID: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com>
Reply-To: david morgan <morgad@eclipse.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Sat Jan 21 15:09:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0JQK-0006wB-Ku
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 15:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWAUOIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 09:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWAUOIf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 09:08:35 -0500
Received: from mra01.ch.as12513.net ([82.153.252.23]:40087 "EHLO
	mra01.ch.as12513.net") by vger.kernel.org with ESMTP
	id S932190AbWAUOIe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 09:08:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by mra01.ch.as12513.net (Postfix) with ESMTP id 3609328C670
	for <git@vger.kernel.org>; Sat, 21 Jan 2006 14:08:28 +0000 (GMT)
Received: from mra01.ch.as12513.net ([127.0.0.1])
 by localhost (mra01.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29860-01-46 for <git@vger.kernel.org>;
 Sat, 21 Jan 2006 14:08:27 +0000 (GMT)
Received: from unknown (unknown [82.152.150.47])
	by mra01.ch.as12513.net (Postfix) with SMTP id 6A9D328C599
	for <git@vger.kernel.org>; Sat, 21 Jan 2006 14:08:27 +0000 (GMT)
To: git@vger.kernel.org
X-Mailer: Forte Agent 3.1/32.783
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14995>

(some lines might have been wrapped by my mailer)


david@tower2:~/cogito$ cg-update
Fetching head...
Fetching objects...
progress: 51 objects, 83346 bytes
Fetching tags...
Tree change:
795023aaeaac0522d6af2fb63a14699c980782b7:d1a89167fbe0287cc43609bf37534ba1a98614d9

Applying changes...
Fast-forwarding 795023aaeaac0522d6af2fb63a14699c980782b7 ->
d1a89167fbe0287cc43609bf37534ba1a98614d9
        on top of 795023aaeaac0522d6af2fb63a14699c980782b7...
david@tower2:~/cogito$ make install
Generating cg-version...
install -m755 -d /home/david/bin
install cg-object-id cg-add cg-admin-lsobj cg-admin-uncommit
cg-branch-add cg-branch-ls cg-reset cg-clone cg-commit cg-diff
cg-export cg-help cg-init cg-log cg-merge cg-mkpatch cg-patch cg-fetch
cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update cg
cg-admin-ls cg-push cg-branch-chg cg-admin-cat cg-clean
cg-admin-setuprepo cg-switch cg-version /home/david/bin
for i in 'cg-cancel:cg-reset' 'commit-id:cg-object-id' \
                'tree-id:cg-object-id' 'parent-id:cg-object-id' \
                'cg-commit-id:cg-object-id' \
                'cg-tree-id:cg-object-id' 'cg-parent-id:cg-object-id'
\
                'cg-pull:cg-fetch'; do \
                old=`echo $i | cut -d : -f 1`; \
                new=`echo $i | cut -d : -f 2`; \
                rm -f /home/david/bin/$old; \
                ln -s $new /home/david/bin/$old; \
        done
install -m755 -d /home/david/lib/cogito
install cg-Xlib cg-Xmergefile cg-Xfetchprogress /home/david/lib/cogito
cd /home/david/bin; \
        for file in cg-object-id cg-add cg-admin-lsobj
cg-admin-uncommit cg-branch-add cg-branch-ls cg-reset cg-clone
cg-commit cg-diff cg-export cg-help cg-init cg-log cg-merge cg-mkpatch
cg-patch cg-fetch cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls
cg-update cg cg-admin-ls cg-push cg-branch-chg cg-admin-cat cg-clean
cg-admin-setuprepo cg-switch cg-version; do \
                sed -e
's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \

s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
\
                       $file > $file.new; \
                cat $file.new > $file; rm $file.new; \
        done
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
cd /home/david/lib/cogito; \
        for file in cg-Xlib cg-Xmergefile cg-Xfetchprogress; do \
                sed -e
's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \

s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
\
                       $file > $file.new; \
                cat $file.new > $file; rm $file.new; \
        done
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
sed: -e expression #1, char 145: unterminated address regex
install -m755 -d /home/david/share/cogito
install -m644 default-exclude /home/david/share/cogito
david@tower2:~/cogito$


net result - a pile of zero length files in /home/david/bin/   :-(

can I just copy the cg-files from to cogito directory over?

Dave
