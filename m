From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 2/2] rebase: teach --autosquash to match on sha1 in addition to message
Date: Wed, 3 Nov 2010 21:49:10 -0700
Message-ID: <5CCA000B-2178-4DF7-8D72-29F95A9BB360@sb.org>
References: <1288838504-69114-1-git-send-email-kevin@sb.org> <1288838504-69114-2-git-send-email-kevin@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 05:49:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDrlH-0001eZ-5N
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 05:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab0KDEtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 00:49:14 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40400 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0KDEtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 00:49:13 -0400
Received: by pzk28 with SMTP id 28so93748pzk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 21:49:12 -0700 (PDT)
Received: by 10.142.164.4 with SMTP id m4mr179516wfe.184.1288846152566;
        Wed, 03 Nov 2010 21:49:12 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id v19sm14771729wfh.0.2010.11.03.21.49.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 21:49:11 -0700 (PDT)
In-Reply-To: <1288838504-69114-2-git-send-email-kevin@sb.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160689>

On Nov 3, 2010, at 7:41 PM, Kevin Ballard wrote:

> Support lines of the form "fixup! 7a235b" that specify an exact commit
> in addition to the normal "squash! Old commit message" form.

I just realized that this only works for sha1's of up to 7 characters.
If you provide more it won't match, as it's comparing against the sha1
given in the todo list. I wonder if it's worth resolving all sha1s to
their full length if the provided string is longer than 7 characters?

-Kevin Ballard
