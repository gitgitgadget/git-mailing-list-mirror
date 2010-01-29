From: Daed Lee <daed@thoughtsofcode.com>
Subject: Partially private repository?
Date: Fri, 29 Jan 2010 17:01:50 -0500
Message-ID: <78d8a6b51001291401ib93976el25c03694d53aaced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 23:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nayuc-0003SK-Fs
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab0A2WBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600Ab0A2WBw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:01:52 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62362 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0A2WBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:01:52 -0500
Received: by ewy19 with SMTP id 19so98310ewy.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 14:01:51 -0800 (PST)
Received: by 10.213.97.4 with SMTP id j4mr1355059ebn.9.1264802510895; Fri, 29 
	Jan 2010 14:01:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138382>

Hi, I'm wondering if git can handle the following use. I have a
project that started as private experiment, but has morphed into
something I'd like to release publicly. I want to give others access
to the repository, but only to commits after a certain cutoff date.
Commits prior to that date have things like hardcoded file paths,
emails, etc. that I'd like to keep private.

I suppose the easiest thing to do would be to create a new repository,
add the project files to it, and make that public, however I'd like to
keep my private commit history along with the public commit history
going forward in a single repository if possible. Is there a way to do
this with git?

Appreciate any pointers in the right direction. Thanks.
