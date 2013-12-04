From: Duy Nguyen <pclouds@gmail.com>
Subject: Use mongoose to test smart-http unconditionally?
Date: Wed, 4 Dec 2013 17:53:09 +0700
Message-ID: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 04 11:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoA5R-0002Ka-4E
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 11:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074Ab3LDKxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 05:53:41 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:46926 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab3LDKxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 05:53:40 -0500
Received: by mail-qc0-f178.google.com with SMTP id i17so3270239qcy.37
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=09P1y8HvghAb5HMCLyJdqfnWdopIVDibZtSs7g5/F7k=;
        b=YBO2ATkYBGvwpjKOcItnjQM/OW0Zd3Igh8rTxn1ESE5Q/hbnAdrF2qwlmHixDtivnq
         3iezvkabRhQ1usF0HOOqFWk9C7KARf0scXZGY7gna/ib6+BWKZNuNrYKHfmcElT64NpB
         OmWnaLHQmgcH6XbDZfLlqc9a/oTfSpilAbZqkaqdZG/tdRQqQ9TKxby+06KQqN7feFQc
         XA27jK6ZR57nRhOpMeMnhCNw7HOdE1vdaehR+hQLbNKBznecTlBV6HZFDKpwkCbs92d2
         Q4bynrHMptx2r21mz89lBAF0Oc6jsCeQFee1OOHrhsw7QP6UfF1INjfuJsGj6J6sMKTC
         9+Hg==
X-Received: by 10.229.49.8 with SMTP id t8mr134035973qcf.21.1386154419781;
 Wed, 04 Dec 2013 02:53:39 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 4 Dec 2013 02:53:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238770>

I was thinking of an alternative to apache for testing smart-http so
that most of http tests could always run. Mongoose [1] looks like a
good candidate to bundle with git. Just one pair of source files,
mongoose.[ch], a mainloop wrapper and we have an http server. Just
wondering, do we rely on any apache-specific features? I'm not so
familiar with lib-httpd.sh..

[1] https://github.com/cesanta/mongoose
-- 
Duy
