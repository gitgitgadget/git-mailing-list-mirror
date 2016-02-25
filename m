From: Alter Depp <Alter.Depp@gmx.de>
Subject: git submodule add --single-branch
Date: Thu, 25 Feb 2016 18:54:59 +0100
Message-ID: <8e46e2f93895fb33421e7b09ccfe7de5@www.hilie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 18:55:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ08I-0006xt-Hf
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbcBYRzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 12:55:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:62311 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381AbcBYRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:55:17 -0500
Received: from www.hilie.de ([88.217.198.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MPlMc-1acs1A0rcA-004x4b for <git@vger.kernel.org>; Thu,
 25 Feb 2016 18:55:14 +0100
X-Sender: Alter.Depp@gmx.de
User-Agent: Roundcube Webmail/0.9.5
X-Provags-ID: V03:K0:RX78Py8lCI4rkzRa0Jr9r+5PtqpKAMVxlhDB8KOMP0gJG31Kudy
 SdM6qx4tnwDj+yQjt0QQfSseUb6eRpcHvcUjDRrSalr/JJ5mwouwqMDoM0FWgKr3jebUjLI
 8HiVTxsiowxcCepxcebsoPN9Aafv0dKVQ5ppgafq8y69gzB17gHg1xUFqK6LUzDV8ri1Q9H
 PYmtDuIgZMeGDv8LF9J7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I4Mkm/7JYD0=:w+urFi9LsqAGbg8X0QLyaV
 Q9tDMOzHNAwwSAiSLPi+csSSub0fa73FYX8iShavkTb6pDaIliRaAq4eTju+UlvSQG8w2QIau
 9QSRqfybAWrCQ4SQFAtpVz0XAMDeocG3WRX3GWwlfktzlCOXsmca9yxsszHz45V0SS84VxsXe
 v2aJyo28CMH5cP0Iifw9+rB/tkF3UyK8mZCv14us5a1JIu/qhNDYAeBOSgVRHyzm+EwHdZPky
 z1pVh/wDvJt9eyTq+JJq6X7tBf+MnCot3HeHrV6sZsL8terOd+EmiaZZTZUcOYXvdzjpyL2cP
 PQCQ0vhlF5bAWMOzau9UsYvyy5b8N+pTwgl1h5HdCDWQlqqBjo1HFWZOYmpCCamdor2dKnBKX
 tI8Y++cEWfB+BcDRfsjSoczVhbJcR4uiVeJMI1KDCuHn26BsmPfpT8Z6JWlrfnd0cADjyxzja
 25jqjMcHVao+Qd5vnZl0FRBbeEOLHHJ+WBc3zUwkUjUL+2qVgMyIG8NCuhvxmlLbBO5CuGuu9
 Y4YRfhYHVqyBTUyDQB95cofKHPwRcdHbfl2e/ES9bp5oa2q8WyCQZ9+jfKF8DliuUwEuqHmPq
 /dQf1ZMhA5aWm7KxESfHjbIXlDErmc+2kHq8ymVKpIIm9DgL8+xu8BCptrGicw4y//QnZR0zT
 h5yHt+LJRA7haOW8PCGasoOyhwEfc0t6YlOrnjg0AXzKg4Z43yong+ot1/Yowx0AvrG2zRUB6
 uWQN3bxDo9vJhXZeCnI7M9cxMNJ1n+JgcOKcW6/48UsVvv5ZJOnY9REChM490+CWibrZp6jM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287408>

I would like to do a shallow clone of a submodule like this:
$ git submodule add --branch master --single-branch --depth 5 repo dir
but it doesn't work. I think '--single-branch' is not yet implemented 
for submodules.

With the clone command it works:
$ git clone --branch master --single-branch --depth 5 repo dir

Is it possible to do something like this with a submodule?

Stefan
