From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Removed Auto-generated TODOs, they don't specify something to do.
Date: Sun, 20 Jan 2008 18:29:01 -0200
Message-ID: <1200860941-6922-1-git-send-email-rogersoares@intelinet.com.br>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 21:29:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGgms-0004S0-K7
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 21:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbYATU2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 15:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbYATU2W
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 15:28:22 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1660 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755253AbYATU2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 15:28:21 -0500
Received: (qmail 70923 invoked by uid 0); 20 Jan 2008 18:31:25 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.804451 secs); 20 Jan 2008 20:31:25 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.202.168)
  by cvxbsd.convex.com.br with SMTP; 20 Jan 2008 20:31:24 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71188>

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../src/org/spearce/egit/core/GitBlobStorage.java  |    3 ---
 .../src/org/spearce/egit/core/GitStorage.java      |    4 ----
 .../internal/mapping/GitCommitFileRevision.java    |    1 -
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    9 ---------
 .../internal/decorators/GitResourceDecorator.java  |    7 -------
 .../ui/internal/factories/GitAdapterFactory.java   |    1 -
 .../org/spearce/jgit/lib/TopologicalWalker.java    |    1 -
 .../src/org/spearce/jgit/lib/Walker.java           |    1 -
 8 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
index f7a062c..65bbb5d 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
@@ -52,7 +52,6 @@ public class GitBlobStorage implements IStorage {
 			String name = repositoryMapping.getRepoRelativePath(resource);
 			entry = tree.findBlobMember(name);
 		} catch (IOException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 	}
@@ -71,7 +70,6 @@ public class GitBlobStorage implements IStorage {
 			throw new ResourceException(IResourceStatus.FAILED_READ_LOCAL,
 					resource.getFullPath(), "Could not read file", e);
 		} catch (IOException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 			throw new ResourceException(33, resource.getFullPath(), e
 					.getMessage(), e);
@@ -87,7 +85,6 @@ public class GitBlobStorage implements IStorage {
 	}
 
 	public boolean isReadOnly() {
-		// TODO Auto-generated method stub
 		return false;
 	}
 
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
index f791e31..70b9f1a 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
@@ -69,7 +69,6 @@ public class GitStorage implements IStorage {
 					entry = treeEntry.getId();
 			}
 		} catch (IOException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 	}
@@ -93,7 +92,6 @@ public class GitStorage implements IStorage {
 			throw new ResourceException(IResourceStatus.FAILED_READ_LOCAL,
 					resource.getFullPath(), "Could not read file", e);
 		} catch (IOException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 			throw new ResourceException(33, resource.getFullPath(), e
 					.getMessage(), e);
@@ -109,12 +107,10 @@ public class GitStorage implements IStorage {
 	}
 
 	public boolean isReadOnly() {
-		// TODO Auto-generated method stub
 		return false;
 	}
 
 	public Object getAdapter(Class adapter) {
-		// TODO Auto-generated method stub
 		return null;
 	}
 
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java
index 6d6f7ea..da0444f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitCommitFileRevision.java
@@ -134,7 +134,6 @@ public class GitCommitFileRevision extends GitFileRevision {
 			else
 				return tree.findTreeMember(path);
 		} catch (IOException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 		return null;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 649df3f..1707859 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -155,7 +155,6 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	public boolean inputSet() {
 		if (viewer != null)
 			viewer.setInput(getInput());
-		// TODO Auto-generated method stub
 		return true;
 	}
 
@@ -875,7 +874,6 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				try {
 					newappliedPatches = repositoryMapping.getRepository().getAppliedPatches();
 				} catch (IOException e) {
-					// TODO Auto-generated catch block
 					e.printStackTrace();
 				}
 				Map<ObjectId,Tag[]> newtags = new HashMap<ObjectId,Tag[]>();
@@ -895,13 +893,11 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 						newtags.put(t.getObjId(), samecommit);
 					}
 				} catch (IOException e) {
-					// TODO Auto-generated catch block
 					e.printStackTrace();
 				}
 				try {
 					currentHead = repositoryMapping.getRepository().resolve("HEAD");
 				} catch (IOException e) {
-					// TODO Auto-generated catch block
 					e.printStackTrace();
 				}
 				Map<ObjectId, String[]> newBranches = new HashMap<ObjectId, String[]>();
@@ -933,7 +929,6 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					newBranches.put(currentHead, samecommit);
 					branches = newBranches;
 				} catch (IOException e) {
-					// TODO Auto-generated catch block
 					e.printStackTrace();
 				}
 				GitFileHistoryProvider fileHistoryProvider = (GitFileHistoryProvider) provider
@@ -1092,12 +1087,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	public boolean isValidInput(Object object) {
-		// TODO Auto-generated method stub
 		return true;
 	}
 
 	public void refresh() {
-		// TODO Auto-generated method stub
 
 	}
 
@@ -1109,14 +1102,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	public ICompareInput getCompareInput(Object object) {
-		// TODO Auto-generated method stub
 		return null;
 	}
 
 	public void prepareInput(ICompareInput input,
 			CompareConfiguration configuration, IProgressMonitor monitor) {
 		System.out.println("prepareInput()");
-		// TODO Auto-generated method stub
 	}
 
 	/**
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index c13c38a..9ab762a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -89,7 +89,6 @@ public class GitResourceDecorator extends LabelProvider implements
 					}
 				});
 			} catch (CoreException e) {
-				// TODO Auto-generated catch block
 				e.printStackTrace();
 			}
 			start();
@@ -129,7 +128,6 @@ public class GitResourceDecorator extends LabelProvider implements
 								// Activator.trace("VCLEARING:"+r.getFullPath().toOSString());
 								clearDecorationState(r);
 							} catch (CoreException e) {
-								// TODO Auto-generated catch block
 								e.printStackTrace();
 							}
 						}
@@ -138,7 +136,6 @@ public class GitResourceDecorator extends LabelProvider implements
 
 				});
 			} catch (CoreException e2) {
-				// TODO Auto-generated catch block
 				e2.printStackTrace();
 				return;
 			}
@@ -211,10 +208,8 @@ public class GitResourceDecorator extends LabelProvider implements
 			}
 			return null; // not mapped
 		} catch (CoreException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} catch (IOException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 		return null;
@@ -342,7 +337,6 @@ public class GitResourceDecorator extends LabelProvider implements
 			//
 			throw new RuntimeException(UIText.Decorator_failedLazyLoading, e);
 		} catch (CoreException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 			throw new RuntimeException(UIText.Decorator_failedLazyLoading, e);
 		}
@@ -394,7 +388,6 @@ public class GitResourceDecorator extends LabelProvider implements
 				}
 			}
 		} catch (CoreException e) {
-			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java
index 53d222a..74b8efa 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/factories/GitAdapterFactory.java
@@ -43,7 +43,6 @@ public class GitAdapterFactory implements IAdapterFactory {
 	}
 
 	public Class[] getAdapterList() {
-		// TODO Auto-generated method stub
 		return null;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java
index 16af0c6..3da6b03 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalWalker.java
@@ -105,7 +105,6 @@ public class TopologicalWalker extends Walker {
 				try {
 					collectSortOrder(succ, repository.mapCommit(succ));
 				} catch (IOException e) {
-					// TODO Auto-generated catch block
 					e.printStackTrace();
 				}
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
index 1f6c531..ca67969 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
@@ -104,7 +104,6 @@ public abstract class Walker {
 			try {
 				next.run();
 			} catch (IOException e) {
-				// TODO Auto-generated catch block
 				e.printStackTrace();
 			}
 			todo.remove(next);
-- 
1.5.3.7
