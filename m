From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: GSOC proposal
Date: Fri, 25 Mar 2011 11:08:35 +0100
Message-ID: <20110325100835.GB30376@paksenarrion.iveqy.com>
References: <20110324220104.GA18721@paksenarrion.iveqy.com>
 <4D8BD358.1030603@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Transfer-Encoding: 8bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33lL-0006xW-W5
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab1CYJ44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 05:56:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33297 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab1CYJ4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:56:55 -0400
Received: by bwz15 with SMTP id 15so772279bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=70p4/NxlDYsKt+Z/3xv7IhPUHOfLIjLAanAHWtXVKX8=;
        b=NrpDP4kMFeCZuqqU/GCwsIuMB80PNeLYRBWsqBv/Bs+gROt2vTbKqY1GxtcyI4L2JO
         4D+N7JT5tgMfdrU7R/xP5Jy3fdAI6U7gDthnP+vndavffg/ro+TGFHE43yUBbsY3Ao5h
         aJMMC5wndZp2fvrwc8BT4e1RE4femCrnstTzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kbdLLC9HQ5utupjAvRyEIIoKzYSp+01M1/2DoZhML2fNNoOimCZBxbSbf9Wj+lH1ux
         YI6XKeHxJNWBCpr5+DCEVnstHLdZBGnd1+qTXOUeJ4XnyYY14CWOzxuW/s+QEeFzJcQe
         jBGhC5Bud5IKOHJ0DH1c8xS2UxAfQT7+QdElE=
Received: by 10.204.22.9 with SMTP id l9mr517972bkb.66.1301047014147;
        Fri, 25 Mar 2011 02:56:54 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id c11sm597109bkc.2.2011.03.25.02.56.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 02:56:53 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Q33wZ-000818-Qv; Fri, 25 Mar 2011 11:08:35 +0100
Content-Disposition: inline
In-Reply-To: <4D8BD358.1030603@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169976>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 25, 2011 at 12:27:20AM +0100, Jens Lehmann wrote:
> > == Threat every module alike ==
> > When failing fetching a submodule, continue fetching the next one
> > instead of dying. There's no need to prevent fetching a submodule
> > beginning at 'z' just because a failing in fetching a submodule
> > beginning at 'a'. The submodules should not be alphabetically dependant
> > as they are now.
> 
> I assume you are talking about the implicit fetch done by "git submodule
> update" here. The recursive submodule fetch that "git fetch" learned
> recently continues to fetch other submodules even if one or more fetches
> failed. But you are right that "git submodule update" should attempt to
> continue updating the remaining submodules too even if one of those
> updates failed along the way (This should be achieved with even less
> effort than the push issue mentioned above, so it would be an even
> easier starting point for people who want to get involved).
> 
> /* snip */
> 
> (And, as every year, it's a good idea for a prospective student to get
> involved in the git community before his application is accepted ...
> sending some patches is a good way to do that, maybe regarding one of
> the first two issues raised here? ;-)

I've attached a patch solving the submodule update-problem. A thing I 
though about is if it's a good idéa to end the output with an error 
summary. A git submodule update with 40-50 modules would easily let 
an error go by undetected with this patch.

-- 
Med vänliga hälsningar
Fredrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com

--CE+1k2dSO48ffgeK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-When-one-submodule-fails-continue-to-the-next.patch"

>From 1bc9a5e69f7b3296bad6dd0449054de8501be5bd Mon Sep 17 00:00:00 2001
From: iveqy <iveqy@iveqy.com>
Date: Fri, 25 Mar 2011 10:43:42 +0100
Subject: [PATCH] When one submodule fails, continue to the next

---
 git-submodule.sh |   60 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..ae3abd1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -342,8 +342,11 @@ cmd_init()
 		test -z "$url" || continue
 
 		url=$(git config -f .gitmodules submodule."$name".url)
-		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
+		if test -z "$url" 
+		then
+			say "No url found for submodule path '$path' in .gitmodules"
+			continue
+		fi
 
 		# Possibly a url relative to parent
 		case "$url" in
@@ -352,13 +355,17 @@ cmd_init()
 			;;
 		esac
 
-		git config submodule."$name".url "$url" ||
-		die "Failed to register url for submodule path '$path'"
+		if !(git config submodule."$name".url "$url")
+		then
+			say "Failed to register url for submodule path '$path'"
+		fi
 
 		upd="$(git config -f .gitmodules submodule."$name".update)"
-		test -z "$upd" ||
-		git config submodule."$name".update "$upd" ||
-		die "Failed to register update mode for submodule path '$path'"
+		if !(test -z "$upd" || git config submodule."$name".update "$upd")
+		then
+			say "Failed to register update mode for submodule path '$path'"
+			continue
+		fi
 
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
@@ -446,9 +453,11 @@ cmd_update()
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-			subsha1=$(clear_local_git_env; cd "$path" &&
-				git rev-parse --verify HEAD) ||
-			die "Unable to find current revision in submodule path '$path'"
+			if !(subsha1=$(clear_local_git_env; cd "$path" && git rev-parse --verify HEAD))
+			then
+				say "Unable to find current revision in submodule path '$path'"
+				continue
+			fi
 		fi
 
 		if ! test -z "$update"
@@ -466,9 +475,11 @@ cmd_update()
 
 			if test -z "$nofetch"
 			then
-				(clear_local_git_env; cd "$path" &&
-					git-fetch) ||
-				die "Unable to fetch in submodule path '$path'"
+				if !(clear_local_git_env; cd "$path" && git-fetch)
+				then
+					say "Unable to fetch in submodule path '$path'"
+					continue
+				fi
 			fi
 
 			# Is this something we just cloned?
@@ -496,15 +507,21 @@ cmd_update()
 				;;
 			esac
 
-			(clear_local_git_env; cd "$path" && $command "$sha1") ||
-			die "Unable to $action '$sha1' in submodule path '$path'"
+			if !(clear_local_git_env; cd "$path" && $command "$sha1")
+			then
+				say "Unable to $action '$sha1' in submodule path '$path'"
+				continue;
+			fi
 			say "Submodule path '$path': $msg '$sha1'"
 		fi
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") ||
-			die "Failed to recurse into submodule path '$path'"
+			if !(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") 
+			then
+				say "Failed to recurse into submodule path '$path'"
+				continue;
+			fi
 		fi
 	done
 }
@@ -790,13 +807,16 @@ cmd_status()
 
 		if test -n "$recursive"
 		then
-			(
+			if ! (
 				prefix="$displaypath/"
 				clear_local_git_env
 				cd "$path" &&
 				eval cmd_status "$orig_args"
-			) ||
-			die "Failed to recurse into submodule path '$path'"
+			) 
+			then
+				say "Failed to recurse into submodule path '$path'"
+				continue
+			fi
 		fi
 	done
 }
-- 
1.7.4.1.433.gcd306.dirty


--CE+1k2dSO48ffgeK--
