From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 0/3] contrib/subtree: Store subtree sources in .gitsubtree
Date: Tue, 19 Feb 2013 12:28:36 +0000
Message-ID: <CALeLG_=KuQQccr=YKqPhzpdi9p1aA+NLgrWo_zT5jxk+FzCYGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 13:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7mJi-00026F-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 13:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685Ab3BSM2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 07:28:38 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:53060 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab3BSM2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 07:28:38 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so3327771eek.11
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 04:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=oYvjF5O4ttHZM8QKZrYZ0cTKEvqHPZKgdkpetXs9ecY=;
        b=oj/SxUTxVb4wNYHUOOFJGSzS6oWS9KLtfyqKNKFl7B/dxKd7gixli+TFneAYUOZxcQ
         jsiz3dEO8E7aKLPlEwttUnfMLQJFWzBkMATcsbl1tvgtpWX9FMtbsUoNyK+SOO1K+2jE
         xMshunoXDGx36LMDs5x8LFoEFvNWCyR/F8GF/0UfD6zPFUCV8mi0hV48yFUIhuaakL9g
         gj2CxF62byXwLJ+M56Juk0cYj8DZjjsucqzyI1RVd0rxrA7WNf9JcGL45vadml8+l47U
         8CEf0oOcWN2/J8D8dD4g+Vl1+ZywLRn2X4G0MUE+18qyvAGVmattZw8Vw22o7eRBDF0K
         dUEw==
X-Received: by 10.14.184.68 with SMTP id r44mr56171622eem.40.1361276916733;
 Tue, 19 Feb 2013 04:28:36 -0800 (PST)
Received: by 10.14.45.4 with HTTP; Tue, 19 Feb 2013 04:28:36 -0800 (PST)
X-Originating-IP: [212.219.195.16]
X-Gm-Message-State: ALoCoQnJA5MqK2IeXwAl2D6UHLjZP8nQnAQTvExUoEVCyra9iGs6VxH8Rr0NLfwEwFK74NXR90V+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216609>

Thanks to Jonathan for the constructive criticism of the tests.  Here
is the latest version.

I suspect I'll need to leave it until after David's changes to the
tests are merged into master, unless anyone thinks I should rebase
elsewhere. I think my tests only need a minor update to accommodate
those changes.

-- 
Paul [W] Campbell
