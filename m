From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Sun, 19 Aug 2012 15:57:19 +0200
Message-ID: <5030F0BF.2090500@alum.mit.edu>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com> <7vboj5gqqo.fsf@alter.siamese.dyndns.org> <loom.20120818T162226-852@post.gmane.org> <7vfw7krl8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 16:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T367C-0007CE-TE
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 16:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab2HSOEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 10:04:25 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:54311 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab2HSOEX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2012 10:04:23 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2012 10:04:23 EDT
X-AuditID: 1207440d-b7f236d000000943-0b-5030f0c1fd00
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C4.45.02371.1C0F0305; Sun, 19 Aug 2012 09:57:21 -0400 (EDT)
Received: from [192.168.69.140] (p57A24F38.dip.t-dialin.net [87.162.79.56])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7JDvJEL009958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 Aug 2012 09:57:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vfw7krl8r.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqHvwg0GAwaZVMhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xv31+xgLFvJVLOpfw9TAeJ+ri5GTQ0LAROL4
	kmYWCFtM4sK99WxdjFwcQgKXGSVaJ39ih3BOM0k8u3CSDaSKV0Bb4m//PUYQm0VAVWL1n09g
	NpuArsSinmYmEFtUIERizbcpjBD1ghInZz4B2yAioCYxse0QkM3BwSwgLtH/DywsLOAucfcp
	yBiQXXcYJa7+uAw2h1PATOLighawImYBHYl3fQ+YIWx5ie1v5zBPYBSYhWTFLCRls5CULWBk
	XsUol5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mil5pSuokREqi8Oxj/r5M5xCjAwajEw6up
	ZRAgxJpYVlyZe4hRkoNJSZT3w1OgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe/1ygHG9KYmVV
	alE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgpcPGJFCgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aBYjS8GRitIigdoLyNIO29xQWIuUBSi9RSjMce8ByfvMnJ8fgok
	hVjy8vNSpcR5dUBKBUBKM0rz4BbBUtQrRnGgv4V5WUCqeIDpDW7eK6BVTECrHs0FW1WSiJCS
	amDMtz+ud3RatOjWqM4Px5xNE0890mLteTe56X+/ss2NsscfBZ49m73g62fBvt7jtyVXzV0m
	tJMtcduEK6sbEiaH7PDxlMhQ9zgS4HvM8nfM4fV/G20X7ny/y2xVqVTrtP3rdE3D 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203720>

On 08/18/2012 10:36 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I can work around the problem by using "--root=/run/shm". 
> 
> I do not necessarily think it is a work around.

http://en.wiktionary.org/wiki/workaround:
2. (computing) A procedure or a temporary fix that bypasses a problem
   and allows the user to continue working until a better solution
   can be provided; a kluge.

For me that is exactly what it was.

> A low-impact approach may be to update the part that parses --root
> option to do
> 
> 	root=$(...)
>         root=$( cd "$root" && /bin/pwd )
> 
> or something.

I just verified that the combination of your two suggestions (i.e., the
patch below) fixes the problem for me.

Nevertheless, I'm not sure that this is the best solution.  The test
failures that occur without this change suggest to me that
GIT_CEILING_DIRECTORIES is implemented in a fragile way.

Michael

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bb4f886..c7f320f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .

+cd "$(pwd -P)"
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 case "$GIT_TEST_TEE_STARTED, $* " in
@@ -166,6 +168,7 @@ do
                shift ;; # was handled already
        --root=*)
                root=$(expr "z$1" : 'z[^=]*=\(.*\)')
+               root=$(cd "$root" && /bin/pwd)
                shift ;;
        *)
                echo "error: unknown test option '$1'" >&2; exit 1 ;;


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
