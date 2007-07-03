From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 14:30:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707031422201.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
	<20070702142557.eba61ccd.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
	<20070702145601.a0dcef0f.akpm@linux-foundation.org>
	<alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
	<7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
	<Pine.LNX.4.64.0707031303130.4071@racer.site>
	<4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
	<20070703183947.GE5322@thunk.org>
	<alpine.LFD.0.98.0707031159580.9434@woody.linux-foundation.org>
	<87zm2dxl5l.fsf@penguin.cs.ucla.edu>
Reply-To: quilt-dev@nongnu.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, quilt-dev@nongnu.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Eggert <eggert@CS.UCLA.EDU>
X-From: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org Tue Jul 03 23:31:19 2007
connect(): Connection refused
Return-path: <quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org>
Envelope-to: gcvqd-quilt-dev@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5pxv-0002ty-CU
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 23:31:19 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1I5pxu-00058u-RA
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 17:31:18 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1I5pxo-00055R-P0
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:31:12 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1I5pxm-000553-VT
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:31:12 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1I5pxm-00054w-Lm
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:31:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.60)
	(envelope-from <torvalds@linux-foundation.org>) id 1I5pxm-0001wd-7P
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:31:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[207.189.120.55]) by smtp2.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	l63LUqNd029807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 14:30:53 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	l63LUkLF016898; Tue, 3 Jul 2007 14:30:46 -0700
In-Reply-To: <87zm2dxl5l.fsf@penguin.cs.ucla.edu>
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
X-detected-kernel: Linux 2.6, seldom 2.4 (older, 4)
X-BeenThere: quilt-dev@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: quilt-dev.nongnu.org
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/quilt-dev>
List-Post: <mailto:quilt-dev@nongnu.org>
List-Help: <mailto:quilt-dev-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=subscribe>
Sender: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Errors-To: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51535>



On Tue, 3 Jul 2007, Paul Eggert wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Anyway, I tried to look at the patch sources, but I had to stop. That 
> > whole "intuit_diff_type()" function is probably designed as an initiation 
> > rite for any patch programmers, and to make sure that you have to be 
> > really serious about wanting to send patches before you can become part of 
> > the "in crowd". It's "mental hazing".
> 
> You should have seen it in the good old days when Larry Wall wrote it.
> It was at least -- at least! -- 10% worse.

Heh.

Anyway, I figured out a sane way to do this - I had been thinking about it 
all wrong. Instead of worrying about all the places that change (and look 
at) "p_indent" - which is the real variable - I just made it not calculate 
"indent" in the first place.

That makes it catch it all in one place, and then quite naturally ignore 
any indented hunks because it won't recognize them as patches any more. At 
least I _think_ so, from just reading the source code.

So a patch like the following may or may not work. It compiles, but quite 
frankly, while it makes sense and worked for the single test-case I 
bothered with, somebody should double-check the logic.

> > In this case, the improvement would be to simply ignore indented patches 
> > (preferably by default, but at least have the option to do so).
> 
> I agree.  POSIX has tied our hands to some extent, though, since it
> _requires_ patch to accept indented patches by default.  It's too late
> to fix this in the current POSIX go-round, but we can fix it in the
> next.  And in the mean time we can add an option, I suppose defaulting
> to not stripping indentation unless POSIXLY_CORRECT is set.  That
> would be fine with me.
> 
> I'll add it to my list of things to do.

Ok, so this doesn't do the POSIXLY_CORRECT thing, and you may not agree 
with the flag name either ("--strip-indent" is a lot of characters to 
write, but I thought it was so esoteric that I think it's ok. I never even 
realized "patch" would ever do something as strange as that, and I'm 
hoping a lot of other people didn't realize either, so that changing this 
isn't going to matter, and very few people would hopefully ever need to 
use the "--strip-indent" flag).

But maybe you can use this patch as a starting point, at least.

(And if you wonder why I put the "if (!strip_indentation)" thing inside 
the loop, even though it doesn't ever change in the loop: it generated a 
smaller patch, and I didn't want to re-indent that code and make it even 
worse. So the logic is kind of stupid, but whatever..)

		Linus

---
diff --git a/common.h b/common.h
index c7fc5c2..45fecdc 100644
--- a/common.h
+++ b/common.h
@@ -174,6 +174,7 @@ XTERN bool canonicalize;
 XTERN int patch_get;
 XTERN bool set_time;
 XTERN bool set_utc;
+XTERN bool strip_indentation;
 
 enum diff
   {
diff --git a/patch.c b/patch.c
index 9e04daf..6e25d2a 100644
--- a/patch.c
+++ b/patch.c
@@ -522,6 +522,7 @@ static struct option const longopts[] =
   {"no-backup-if-mismatch", no_argument, NULL, CHAR_MAX + 6},
   {"posix", no_argument, NULL, CHAR_MAX + 7},
   {"quoting-style", required_argument, NULL, CHAR_MAX + 8},
+  {"strip-indent", no_argument, NULL, CHAR_MAX + 9},
   {NULL, no_argument, NULL, 0}
 };
 
@@ -580,6 +581,7 @@ static char const *const option_help[] =
 "  --verbose  Output extra information about the work being done.",
 "  --dry-run  Do not actually change any files; just print what would happen.",
 "  --posix  Conform to the POSIX standard.",
+"  --strip-indent handle indented patches.",
 "",
 "  -d DIR  --directory=DIR  Change the working directory to DIR first.",
 #if HAVE_SETMODE_DOS
@@ -779,6 +781,9 @@ get_some_switches (void)
 				     (enum quoting_style) i);
 		}
 		break;
+	    case CHAR_MAX + 9: /* --strip-indent */
+		strip_indentation = true;
+		break;
 	    default:
 		usage (stderr, 2);
 	}
diff --git a/pch.c b/pch.c
index d98af86..fcb08c5 100644
--- a/pch.c
+++ b/pch.c
@@ -345,6 +345,8 @@ intuit_diff_type (void)
 	}
 	strip_trailing_cr = 2 <= chars_read && buf[chars_read - 2] == '\r';
 	for (s = buf; *s == ' ' || *s == '\t' || *s == 'X'; s++) {
+	    if (!strip_indentation)
+		break;
 	    if (*s == '\t')
 		indent = (indent + 8) & ~7;
 	    else
