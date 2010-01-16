From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove some junk characters from COPYING
Date: Fri, 15 Jan 2010 21:38:34 -0800
Message-ID: <7vpr5ahan9.fsf@alter.siamese.dyndns.org>
References: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com>
 <201001160209.22589.robin.rosenberg@dewire.com>
 <f3271551001152000r6facd476we7f0a1d3ed5cdf87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 06:39:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW1Nv-0001DB-7M
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 06:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955Ab0APFiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 00:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877Ab0APFiu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 00:38:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab0APFit (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 00:38:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88EE691D2D;
	Sat, 16 Jan 2010 00:38:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vUX1ZoGQmPJWPn18h1K4B6c48OA=; b=yiOuW5
	JGs+Bagb4NNNSgzLnT3XyEaURE/ju3ax1/zlVnelEUT7TvjIv6+WAvAX5uRz+MA3
	ZpKPa4hl7PnPaCuwVnlQixTOd9ush7fSeCKdNiSK9dKK6BAW0TCaqqkQrk9NJUbn
	aF26vMfnH9lJHmqX9bH9dnLsSOrTyrIIkPzMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnsbHHvNvwLzvSmrlNTY1Ri0kg7/3Lkk
	JcSzqB9atD9Z0NBf10HiPQLtsItF3yynKxJKwBupwwQCYMoiT4R0JQSLluQPZZpZ
	gp15pho3NPXLizZMLQ99rJF4o5cMudZlCTwkvV50/x2PYZIdN0oB8b4qvp5gezhO
	63tvoUUc1sc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4535091D2C;
	Sat, 16 Jan 2010 00:38:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0570291D2B; Sat, 16 Jan
 2010 00:38:35 -0500 (EST)
In-Reply-To: <f3271551001152000r6facd476we7f0a1d3ed5cdf87@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat\, 16 Jan 2010 09\:30\:42 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 674B5B30-0261-11DF-A522-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137202>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> It is a form-feed (force new page when printing) so it should probably be
>> called by that name, if it were to be removed.
>
> Oh, thanks for that- I just looked it up. I don't know if they should
> be removed at all.

Most likely the copy we have is what Linus copied from the kernel tree and
adjusted his preamble without touching these form feeds.

While I don't think these form-feeds alone would be a good enough reason
to touch the file, FSF's address has changed some time ago, and the copy
we have does not reflect it, while the copy in the kernel tree was updated
in Sep 2005.  Curiously enough, the copy in the kernel tree doesn't have
the more recent update to rename "GNU Library General Public License" to
"GNU Lesser General Public License" (I am CC'ing Linus in case he cares).

I'll update our copy with http://www.gnu.org/licenses/gpl-2.0.txt.  This
will automatically lose the form-feeds.

Thanks.

-- >8 --
Subject: Update COPYING with GPLv2 with new FSF address

The mailing address of FSF changed quite a while ago.  Also the expansion
of the acronym LGPL (which we don't use) is "Lesser GPL" not "Library GPL"
these days in recent copies of GPLv2.  Update the copy we have with a
fresh download of <http://www.gnu.org/licenses/gpl-2.0.txt>.

This incidentally removes form-feeds in the text we retained for all these
years.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
diff --git a/COPYING b/COPYING
index 6ff87c4..536e555 100644
--- a/COPYING
+++ b/COPYING
@@ -22,8 +22,8 @@
 		    GNU GENERAL PUBLIC LICENSE
 		       Version 2, June 1991
 
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
+ 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -36,7 +36,7 @@ software--to make sure the software is free for all its users.  This
 General Public License applies to most of the Free Software
 Foundation's software and to any other program whose authors commit to
 using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
+the GNU Lesser General Public License instead.)  You can apply it to
 your programs, too.
 
   When we speak of free software, we are referring to freedom, not
@@ -76,7 +76,7 @@ patent must be licensed for everyone's free use or not licensed at all.
 
   The precise terms and conditions for copying, distribution and
 modification follow.
-
+
 		    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
@@ -131,7 +131,7 @@ above, provided that you also meet all of these conditions:
     License.  (Exception: if the Program itself is interactive but
     does not normally print such an announcement, your work based on
     the Program is not required to print an announcement.)
-
+
 These requirements apply to the modified work as a whole.  If
 identifiable sections of that work are not derived from the Program,
 and can be reasonably considered independent and separate works in
@@ -189,7 +189,7 @@ access to copy from a designated place, then offering equivalent
 access to copy the source code from the same place counts as
 distribution of the source code, even though third parties are not
 compelled to copy the source along with the object code.
-
+
   4. You may not copy, modify, sublicense, or distribute the Program
 except as expressly provided under this License.  Any attempt
 otherwise to copy, modify, sublicense or distribute the Program is
@@ -246,7 +246,7 @@ impose that choice.
 
 This section is intended to make thoroughly clear what is believed to
 be a consequence of the rest of this License.
-
+
   8. If the distribution and/or use of the Program is restricted in
 certain countries either by patents or by copyrighted interfaces, the
 original copyright holder who places the Program under this License
@@ -299,7 +299,7 @@ PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
 
 		     END OF TERMS AND CONDITIONS
-
+
 	    How to Apply These Terms to Your New Programs
 
   If you develop a new program, and you want it to be of the greatest
@@ -324,10 +324,9 @@ the "copyright" line and a pointer to where the full notice is found.
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-
+    You should have received a copy of the GNU General Public License along
+    with this program; if not, write to the Free Software Foundation, Inc.,
+    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 Also add information on how to contact you by electronic and paper mail.
 
@@ -357,5 +356,5 @@ necessary.  Here is a sample; alter the names:
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
 consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
+library.  If this is what you want to do, use the GNU Lesser General
 Public License instead of this License.
