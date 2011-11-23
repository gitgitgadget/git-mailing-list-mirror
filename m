From: Paul Brossier <piem@piem.org>
Subject: git not resuming push
Date: Tue, 22 Nov 2011 20:58:56 -0700
Message-ID: <4ECC6F80.6010907@piem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 05:18:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT4Hf-0004Fs-JI
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 05:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759647Ab1KWESB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 23:18:01 -0500
Received: from goyave.piem.org ([213.251.135.79]:49626 "EHLO goyave.piem.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758375Ab1KWESB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 23:18:01 -0500
X-Greylist: delayed 1133 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Nov 2011 23:18:00 EST
Received: from localhost ([127.0.0.1] helo=groseille.lan)
	by goyave.piem.org with esmtp (Exim 4.72)
	(envelope-from <piem@piem.org>)
	id 1RT3zD-0000ks-NF
	for git@vger.kernel.org; Wed, 23 Nov 2011 04:59:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185818>

Hi!

I'm trying to upload large amount of data from a connection that often
cuts.

If the connection fails after uploading part of the data, it seems I
need to start over from zero again. Is there a way to resume the upload
instead?

Here is an example:

$ git push
Counting objects: 504, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (475/475), done.
Write failed: Broken pipe1/476), 533.78 MiB | 60 KiB/s
fatal: The remote end hung up unexpectedly
error: pack-objects died of signal 13
error: failed to push some refs to 'myhost.org:/git/myrepo/'

$ git push
Counting objects: 504, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (475/475), done.
Writing objects:  12% (61/476), 89.34 MiB | 23 KiB/s

Thanks, piem
