From: dave morgan <morgad@eclipse.co.uk>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 21:22:26 +0000
Organization: the great unwashed
Message-ID: <4e95t11nt21liep8b875cq5riev381arcu@4ax.com>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com> <20060121194826.GK28365@pasky.or.cz> <BAYC1-PASMTP061F43C7F760A9FB73B616AE1E0@CEZ.ICE> <7vmzhpl4r7.fsf@assigned-by-dhcp.cox.net> <20060121210622.GO28365@pasky.or.cz>
Reply-To: david morgan <morgad@eclipse.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jan 21 22:23:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0QCT-00015V-44
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 22:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWAUVWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 16:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWAUVWy
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 16:22:54 -0500
Received: from mra02.ch.as12513.net ([82.153.252.24]:37009 "EHLO
	mra02.ch.as12513.net") by vger.kernel.org with ESMTP
	id S932356AbWAUVWx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 16:22:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by mra02.ch.as12513.net (Postfix) with ESMTP id EC49AD44BB;
	Sat, 21 Jan 2006 21:22:26 +0000 (GMT)
Received: from mra02.ch.as12513.net ([127.0.0.1])
 by localhost (mra02.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00648-01-2; Sat, 21 Jan 2006 21:22:26 +0000 (GMT)
Received: from unknown (unknown [82.152.150.47])
	by mra02.ch.as12513.net (Postfix) with SMTP id 22BA8D4257;
	Sat, 21 Jan 2006 21:22:26 +0000 (GMT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060121210622.GO28365@pasky.or.cz>
X-Mailer: Forte Agent 3.1/32.783
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15021>

On Sat, 21 Jan 2006 22:06:22 +0100, Petr Baudis <pasky@suse.cz> wrote:

>Dear diary, on Sat, Jan 21, 2006 at 09:12:28PM CET, I got a letter
>where Junio C Hamano <junkio@cox.net> said that...
>> I got a complaint or two that some version of sed does not like
>> ';' to concatenate more than one commands, and have been trying
>> to train myself to do either multiple -e options or multi-line
>> scripts.  E.g when I am tempted to say:
>> 
>> 	sed -e 's/foo/bar/;s/baz/boa/' froboz
>> 
>> Instead, I say either
>> 
>> 	sed -e 's/foo/bar/' -e 's/baz/boa/' froboz
>
>Good idea, thanks. Hopefully this will fix Dave Morgan's problem.
>Committed and pushed out.

david@tower2:~/cogito$ cg-update -v
Fetching head...
Fetching objects...
progress: 27 objects, 33087 bytes
Fetching tags...
Tree change:
d1a89167fbe0287cc43609bf37534ba1a98614d9:3311308023fcbd526b37dfdc61e641ca18bc7f99
:100644 100644 f1fc272... 25a1d21... M  Makefile
:100755 100755 2970d86... 0021080... M  cg-admin-uncommit
:100755 100755 c7423ee... 8c2e852... M  cg-fetch
:100755 100755 9296e0f... 3b6defd... M  cg-merge
:100755 100755 5fd3f5b... 317d7e6... M  cg-push
:100755 100755 06a16fe... a2df345... M  cg-update

Applying changes...
Fast-forwarding a9c75f3b8b1adb01859ff2c9b028f72a247837c6 ->
3311308023fcbd526b37dfdc61e641ca18bc7f99
        on top of a9c75f3b8b1adb01859ff2c9b028f72a247837c6...
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
's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g' \
                    -e
's/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
\
                       $file > $file.new; \
                cat $file.new > $file; rm $file.new; \
        done
cd /home/david/lib/cogito; \
        for file in cg-Xlib cg-Xmergefile cg-Xfetchprogress; do \
                sed -e
's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g' \
                    -e
's/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
\
                       $file > $file.new; \
                cat $file.new > $file; rm $file.new; \
        done
install -m755 -d /home/david/share/cogito
install -m644 default-exclude /home/david/share/cogito
david@tower2:~/cogito$


works for me :-)

many thanks to all for sorting it out

best regards
Dave
