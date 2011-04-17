From: Thiago Farina <tfransosi@gmail.com>
Subject: problem when using --cc-cmd
Date: Sun, 17 Apr 2011 19:32:12 -0300
Message-ID: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 00:32:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBaW4-0007RQ-Pu
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 00:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab1DQWcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 18:32:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44948 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab1DQWcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 18:32:13 -0400
Received: by iyb14 with SMTP id 14so3446751iyb.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=O3Ie/BhDCDzw0Gz5+0wHDrXyp8TPzKFuGKdtWgJQrAQ=;
        b=e5QYk7wUBXWxsYhkTJFP85z8Bwk76f6efKG8Oq5tHt0qndej8ibQkFj00haK6cD744
         3v0nUkCrDSb/6SmFe1feSdMEK1Mhe97Jawj0lOeGcPi/h/aPe0WrbMK/36BUlOnbjwrK
         xj3Q/AUhyf+01/qGDv5mq0ZiycFMxbqSwg5ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=N65GCaVz+h4ExTkI7TceVrtlqBthCzuQnvUIgLfac2Yyx6XLOZlJYMVfGG/OWr1m1S
         unIt+6OIMU9XbxFhg32tHJIlYnJv4kC3VmpI67V8OxCBAuYDDqbghnpd3GT8/doOBdR6
         9jSrdVrbErfRNMfdp+EjqnDE7arOSsMEMM93U=
Received: by 10.42.163.200 with SMTP id d8mr273888icy.164.1303079532716; Sun,
 17 Apr 2011 15:32:12 -0700 (PDT)
Received: by 10.42.171.196 with HTTP; Sun, 17 Apr 2011 15:32:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171731>

Hi,

I'm trying to use the --cc-cmd to get the list of people who to copy
when sending a patch to linux kernel.

But when I run:

$ git send-email --to linux-kernel@vger.kernel.org --cc-cmd
scripts/get_maintainer.pl foo

I'm getting some lines like:
Use of uninitialized value $cc in string eq at
/home/tfarina/libexec/git-core/git-send-email line 964.

Any idea?

Thanks in advance.
