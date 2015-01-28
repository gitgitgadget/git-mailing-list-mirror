From: Mike Hommey <mh@glandium.org>
Subject: Score in diff-format
Date: Wed, 28 Jan 2015 15:23:09 +0900
Message-ID: <20150128062309.GA29506@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 07:23:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGM25-0001wz-N5
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 07:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760962AbbA1GXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 01:23:18 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:40010 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760874AbbA1GXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 01:23:17 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YGM1t-0005Wc-LX
	for git@vger.kernel.org; Wed, 28 Jan 2015 15:23:09 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263102>

Hi,

diff-format.txt says this:

  An output line is formatted this way:
  (snip)

  That is, from the left to the right:

  (snip)
  . status, followed by optional "score" number.

  (snip)
  Status letters C and R are always followed by a score (denoting the
  percentage of similarity between the source and target of the move or
  copy), and are the only ones to be so.

As I read this last paragraph, the following is not supposed to happen:
$ git diff-tree 926b1ec63ee045503f609e88ca445b94c06bd5d7 --abbrev -r -C -B
926b1ec63ee045503f609e88ca445b94c06bd5d7
:100644 100644 81ac702... 7ab0cf4... M087       contrib/subtree/INSTALL

It however makes sense that it happens, and it looks like a case of the
documentation being outdated or confusing. Or am I interpreting it wrong?

Cheers,

Mike
