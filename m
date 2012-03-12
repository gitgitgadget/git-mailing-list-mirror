From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] perf improvements past v1.7.10
Date: Mon, 12 Mar 2012 22:28:45 +0700
Message-ID: <CACsJy8BQXvX6iOH0txcw5wmW-2ddnG3A39BxsrspfkqPTwDy_g@mail.gmail.com>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:29:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S77BZ-0005N5-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab2CLP3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:29:18 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35057 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862Ab2CLP3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:29:16 -0400
Received: by wejx9 with SMTP id x9so3344020wej.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yspfTWTmnz1GQ+VH6xvcs51H6rnuPMOCKn6Ez/P5+Fs=;
        b=uXXQAO2a70QDT9cLdI/Jt6EYlwoNY8W1UtWnG+GXdE21q9neQno+rDlnPQ11djVHbI
         55QCUkqhVEN6o8Q7qC/IfFeHsE60n8YOg8Zj7msdAwLJAINvw0RLCb7gA/h6f3/TtU8V
         2BTyN5XzPbGGmJgDRMlEa2+U4c8ACq4h0K5ZKQjwmAtMnDyUpzWnDvblRg56kvt6BfMW
         o9Y6CWWpIUjtnkUl6LIjS384EEYEpm3xKACGz+2KroJPT7223NrO0vjr9kGd3H0WQprG
         Zvxkh1xPkQNNYXGZC3xLzcw5VmnQOiTB6zrEmgAFkelJ8jIT3j1WvzAY6d9UZmGSUGgE
         Jyzg==
Received: by 10.180.91.10 with SMTP id ca10mr27664807wib.17.1331566155433;
 Mon, 12 Mar 2012 08:29:15 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Mon, 12 Mar 2012 08:28:45 -0700 (PDT)
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192888>

Not really related to the series, how do I compare the same tests on
different repositories? These repositories share the same DAG, but may
have different object representation (all loose, single pack, zillion
of packs, different versions of pack...)
-- 
Duy
