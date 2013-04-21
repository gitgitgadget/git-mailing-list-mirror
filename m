From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 01:17:56 -0700
Message-ID: <20130421081755.GH10429@elie.Belkin>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com>
 <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
 <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org>
 <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
 <20130421080907.GF10429@elie.Belkin>
 <CALkWK0=BkCxhGvjWwTHe83LHQ7R2t-EAMr6H9VQ1AvBjgYerBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:18:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpTR-0006Eu-R6
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab3DUISG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:18:06 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:33475 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab3DUISF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:18:05 -0400
Received: by mail-pb0-f48.google.com with SMTP id xb4so193274pbc.7
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZDYwK7UEkoS+mE5LBqcCPjgm4SDDwRZaPS/bQTO3kRI=;
        b=SjzxnHtGw+m7YXLb3VjrC5EcKav5bkqD5PzU6IN/H/HB8L7VF9i+ftvakEnB0ZqXjP
         kp32VHqlc2lLrHzcjOpREUf3KzuQORAhUsf6nyTlfOzpBJjWTz8pX8AdQIizZGROfyQl
         XlU0nh3N5BtA79cGMazVvDATNR3VlEafACjDiq2hK3QM54S+J8CyeRR4LHEe1rNA3vCw
         krcvS0jSwc002CTPYXHERU54LkPsP4xEe3ARN0CKIwWIT1gw37XiGHj79rmTjBiIpXjh
         GNkA+rWyIMDj7mICH+xvgf22wxeQb/JWzyusygIBZavL3xgdWfp24s8FcgfA5figIQIp
         ICVA==
X-Received: by 10.66.102.106 with SMTP id fn10mr22831425pab.192.1366532284628;
        Sun, 21 Apr 2013 01:18:04 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id be10sm20180683pbd.30.2013.04.21.01.18.02
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:18:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=BkCxhGvjWwTHe83LHQ7R2t-EAMr6H9VQ1AvBjgYerBA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221919>

Ramkumar Ramachandra wrote:

> Yes.  If master@{3}~2:README isn't a revision, what is it?

An extended SHA1 expression referring to a blob.
